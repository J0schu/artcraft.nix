{
  description = "ArtCraft creative apps flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

      packagesFor = import ./nix/packages.nix;
      modules = import ./nix/modules.nix { inherit packagesFor; };
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          apps = packagesFor pkgs;
          all = pkgs.symlinkJoin {
            name = "artcraft-all";
            paths = lib.attrValues apps;
          };
        in
        apps
        // {
          inherit all;
          default = all;
        }
      );

      nixosModules.default = modules.nixos;
      homeModules.default = modules.homeManager;

      overlays.default = final: _prev: { artcraft = packagesFor final; };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            actionlint
            curl
            jq
            nixfmt-tree
            shellcheck
          ];
        };
      });

      apps = forAllSystems (pkgs: {
        update = {
          type = "app";
          meta.description = "Update sources.json to the latest upstream releases";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "artcraft-update";
              runtimeInputs = with pkgs; [
                coreutils
                curl
                gawk
                jq
              ];
              text = ''exec bash ./update.sh "$@"'';
            }
          );
        };
      });
    };
}
