{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # Build dependencies
        nativeBuildInputs = with pkgs; [
          odin
        ];
        # Runtime dependencies
        buildInputs = with pkgs; [
        ];
      in
      {
        devShell = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          # Developer dependencies
          packages = with pkgs; [
            ols
            libGL
            xorg.libX11
          ];
          LD_LIBRARY_PATH =
            with pkgs;
            "$LD_LIBRARY_PATH:${
              pkgs.lib.makeLibraryPath [
                libGL
                xorg.libX11
              ]
            }";
        };
      }
    );
}
