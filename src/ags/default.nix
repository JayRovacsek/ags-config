{ dream2nix, config, ... }: {
  imports = [
    dream2nix.modules.dream2nix.nodejs-package-lock-v3
    dream2nix.modules.dream2nix.nodejs-granular-v3
  ];

  name = "ags";
  version = "1.4.0";

  deps = { nixpkgs, ... }: {
    inherit (nixpkgs) coreutils typescript stdenv lib fetchFromGitHub;
  };

  mkDerivation = {
    nativeBuildInputs = with config.deps; [ typescript ];

    src = config.deps.fetchFromGitHub {
      owner = "Aylur";
      repo = "ags";
      rev = "v1.4.0";
      fetchSubmodules = true;
      sha256 = "sha256-CEw7g5+f0meOM5lqslGZuzImVdvor/2R8jvW9vUSyZI=";
    };

    patches = [ ./basic-compile-fixes.patch ];

    buildPhase = ''
      ${config.deps.coreutils}/bin/mkdir -p $out/lib/node_modules/ags
      ${config.deps.coreutils}/bin/rm -rf $out/lib/node_modules/ags/*
      ${config.deps.coreutils}/bin/cp $src/package.json $out/lib/node_modules/ags
      ${config.deps.typescript}/bin/tsc -p tsconfig.json --outDir $out/lib/node_modules/ags
    '';
  };

  nodejs-package-lock-v3.packageLockFile =
    "${config.mkDerivation.src}/package-lock.json";
}
