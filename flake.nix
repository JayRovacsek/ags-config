{
  description = "ags-config package & supporting code";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    dream2nix = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
      url = "github:nix-community/dream2nix";
    };

    flake-compat = {
      flake = false;
      url = "github:edolstra/flake-compat";
    };

    flake-utils = { url = "github:numtide/flake-utils"; };

    gitignore = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/gitignore.nix";
    };

    pre-commit-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        gitignore.follows = "gitignore";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/pre-commit-hooks.nix";
    };
  };

  outputs = inputs@{ self, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        name = "ags-config";
      in {
        # Pre-commit hooks to enforce formatting, lining, find 
        # antipatterns and ensure they don't reach upstream
        checks = {
          default = self.outputs.checks.${system}.pre-commit;
          pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
            src = self;
            hooks = {
              # Builtin hooks
              deadnix.enable = true;
              eslint.enable = true;
              nixfmt.enable = true;
              prettier.enable = true;
              statix.enable = true;

              # Custom hooks
              statix-write = {
                enable = true;
                name = "Statix Write";
                entry = "${pkgs.statix}/bin/statix fix";
                language = "system";
                pass_filenames = false;
              };
            };

            # Settings for builtin hooks, see also: https://github.com/cachix/pre-commit-hooks.nix/blob/master/modules/hooks.nix
            settings = {
              deadnix.edit = true;
              nixfmt.width = 80;
              prettier.write = true;
            };
          };
        };

        # Shell environments (applied to both nix develop and nix-shell via
        # shell.nix in top level directory)
        devShells = {
          ${name} = pkgs.mkShell {
            inherit name;
            inherit (self.outputs.checks.${system}.default) shellHook;
            packages = with pkgs; [
              deadnix
              nixfmt
              statix
              nil
              nodePackages.prettier
            ];
          };
          default = self.outputs.devShells.${system}.${name};
        };
        # Formatter option for `nix fmt` - redundant via checks but nice to have
        formatter = pkgs.nixfmt;

        # Locally defined packages for flake consumption or consumption
        # on the nur via: pkgs.nur.repos.JayRovacsek if utilising the nur overlay
        # (all systems in this flake apply this opinion via the common.modules)
        # construct
        packages = inputs.dream2nix.lib.importPackages {
          projectRoot = ./.;
          # can be changed to ".git" or "flake.nix" to get rid of .project-root
          projectRootFile = "flake.nix";
          packagesDir = ./src;
          packageSets.nixpkgs = pkgs;
        };
      });
}
