{ dream2nix, ... }: {
  imports = [ dream2nix.modules.dream2nix.mkDerivation ];

  name = "ags-config";
  version = "0.0.1";

  deps = { nixpkgs, ... }: { inherit (nixpkgs) stdenv; };

  mkDerivation = {
    src = ./.;
    installPhase = ''
      mkdir -p $out/share
      cp -r $src/* $out/share
    '';
  };
}
