{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, git-hooks }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in
    {
      checks = forAllSystems (system: {
        pre-commit-check = git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            shellcheck = {
              enable = true;
              args = [ "--shell=bash" "-e" "SC1090" "-e" "SC1091" ];
              files = "\\.sh$";
              excludes = [ "agnostic/zsh\\.sh$" ];
            };
            deadnix.enable = true;
            statix.enable = true;
          };
        };
      });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "my-dotfiles";
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            packages = with pkgs; [
              shellcheck
            ];
          };
        }
      );
    };
}
