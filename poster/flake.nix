{
  description = "ECMOR 2026 poster";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        srcPath = builtins.path {
            path = ./.;
            name = "poster-src";
        };
      in
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "poster";
          src = srcPath;
          buildInputs = [
            pkgs.typst
          ];
          buildPhase = ''
            typst -pdf $src/poster.tex
          '';
          installPhase = ''
            mkdir -p $out
            cp poster.pdf $out/
            cp poster.svg $out/
            cp poster.png $out/
          '';

          dontUnpack = true;
          dontPatch = true;
          dontConfigure = true;
        };
      }
    );
}
