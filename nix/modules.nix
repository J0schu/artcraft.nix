{
  packagesFor,
}:
let
  appNames = builtins.attrNames (import ./apps.nix);

  options =
    { lib, ... }:
    {
      options.programs.artcraft = {
        enable = lib.mkEnableOption "the ArtCraft creative apps";
        apps = lib.mkOption {
          type = lib.types.listOf (lib.types.enum appNames);
          default = [ ];
          example = [
            "photocraft"
            "vectorcraft"
          ];
          description = "Which ArtCraft apps to install.";
        };
      };
    };

  selected = cfg: pkgs: map (name: (packagesFor pkgs).${name}) cfg.apps;

  emptyWarning =
    lib: cfg:
    lib.optional (
      cfg.enable && cfg.apps == [ ]
    ) "programs.artcraft.enable is set but programs.artcraft.apps is empty, nothing will be installed.";
in
{
  nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.artcraft;
    in
    {
      imports = [ options ];
      config = lib.mkIf cfg.enable {
        environment.systemPackages = selected cfg pkgs;
        warnings = emptyWarning lib cfg;
      };
    };

  homeManager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.artcraft;
    in
    {
      imports = [ options ];
      config = lib.mkIf cfg.enable {
        home.packages = selected cfg pkgs;
        warnings = emptyWarning lib cfg;
      };
    };
}
