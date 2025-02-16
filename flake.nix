{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = import inputs.systems;
    perSystem = { pkgs, ... }: {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          dos2unix
          fd
          git
          git-lfs
          go
          jq
          moreutils
        ];
      };
    };
  };
}
