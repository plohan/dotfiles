{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs =
  { nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    with pkgs; {
      devShells.default = mkShell {
        packages = [
          nodePackages.pnpm
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.prisma
          nodejs_22
          nest-cli
        ];
        PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine";
        PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine";
        PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node";
        PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt";
      };
    }
  );
}
