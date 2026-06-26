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
              # Default type filter is "shell" which misses extensionless config
              # files under .shell_config/. Override to "text" so the files regex
              # alone controls what gets checked.
              types = lib.mkForce [ "text" ];
              files = "(\\.sh$|\\.shell_config/)";
              excludes = [ "\\.shell_config/agnostic/zsh$" ];
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
