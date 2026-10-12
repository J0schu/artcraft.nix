pkgs:
let
  inherit (pkgs) lib;
  mkApp = pkgs.callPackage ./package.nix { };
  apps = import ./apps.nix;
  sources = lib.importJSON ../sources.json;
in
lib.mapAttrs (name: app: mkApp (app // { inherit name; } // sources.${name})) apps
