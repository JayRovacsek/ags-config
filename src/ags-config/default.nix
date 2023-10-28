{ dream2nix, config, specialArgs, self }:
let src = ./.;
in {
  imports = [
    dream2nix.modules.dream2nix.nodejs-package-lock-v3
    dream2nix.modules.dream2nix.nodejs-granular-v3
  ];

  name = "ags-config";
  version = "0.0.1";

  deps = { nixpkgs, ... }:
    let inherit (nixpkgs) system;
    in {
      inherit (nixpkgs) coreutils stdenv;
      inherit (specialArgs.self.packages.${system}) ags;
    };

  mkDerivation = {
    propagatedBuildInputs = [ config.deps.ags ];

    installPhase = ''
      ${config.deps.coreutils}/bin/cp -r ${config.deps.ags}/lib/node_modules/ags $out/lib/node_modules/ags-config/node_modules
    '';

    inherit src;
  };

  nodejs-package-lock-v3.packageLockFile = "${src}/package-lock.json";
}
