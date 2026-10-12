<h1 align="center">artcraft.nix</h1>

<p align="center">
  A self-updating Nix flake for the <a href="https://getartcraft.com/">ArtCraft</a> Crafting Apps.<br>
  Pick the apps you want with a Home Manager or NixOS module, or just <code>nix run</code> them.
</p>

<p align="center">
  <a href="https://github.com/J0schu/artcraft.nix/actions/workflows/update.yml"><img alt="update" src="https://github.com/J0schu/artcraft.nix/actions/workflows/update.yml/badge.svg"></a>
  <img alt="platforms" src="https://img.shields.io/badge/platforms-x86__64--linux%20%7C%20aarch64--linux-lightgrey">
</p>

Packages the official AppImages from the [storytold](https://github.com/storytold) releases.

## Apps

| App | Description | Version |
| --- | --- | --- |
| [PhotoCraft](https://github.com/storytold/photocraft) | Image editor with layers, masks, type and PSD support | [![photocraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.photocraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/photocraft/releases/latest) |
| [VectorCraft](https://github.com/storytold/vectorcraft) | Vector illustration, SVG and PDF editor | [![vectorcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.vectorcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/vectorcraft/releases/latest) |
| [FilmCraft](https://github.com/storytold/filmcraft) | Video editor with color and sound tools | [![filmcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.filmcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/filmcraft/releases/latest) |
| [LightCraft](https://github.com/storytold/lightcraft) | Photo library and non-destructive raw developer | [![lightcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.lightcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/lightcraft/releases/latest) |
| [PdfCraft](https://github.com/storytold/pdfcraft) | Read, organize, combine, split and secure PDFs | [![pdfcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.pdfcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/pdfcraft/releases/latest) |
| [EffectCraft](https://github.com/storytold/effectcraft) | Motion graphics and visual effects compositor | [![effectcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.effectcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/effectcraft/releases/latest) |
| [DesignCraft](https://github.com/storytold/designcraft) | Page layout for magazines, books and print documents | [![designcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.designcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/designcraft/releases/latest) |
| [CADCraft](https://github.com/storytold/cadcraft) | 2D computer-aided design and drafting (DXF/DWG) | [![cadcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.cadcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/cadcraft/releases/latest) |
| [DeckCraft](https://github.com/storytold/deckcraft) | Create and present slide decks | [![deckcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.deckcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/deckcraft/releases/latest) |
| [GridCraft](https://github.com/storytold/gridcraft) | Calculate, analyse and chart data in workbooks | [![gridcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.gridcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/gridcraft/releases/latest) |
| [SoundCraft](https://github.com/storytold/soundcraft) | Record, edit and mix audio and MIDI | [![soundcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.soundcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/soundcraft/releases/latest) |
| [WordCraft](https://github.com/storytold/wordcraft) | Write and design documents; open and save Word files | [![wordcraft version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FJ0schu%2Fartcraft.nix%2FHEAD%2Fsources.json&query=%24.wordcraft.version&prefix=v&label=&color=informational&style=flat-square)](https://github.com/storytold/wordcraft/releases/latest) |

The package name is the lowercase app name (`photocraft`, `wordcraft`, ...).
Click a badge for the upstream release page.

## Usage

```nix
inputs.artcraft.url = "github:J0schu/artcraft.nix";
```

### Home Manager

Import the module and list the apps you want:

```nix
{ inputs, ... }:
{
  imports = [ inputs.artcraft.homeManagerModules.default ];

  programs.artcraft = {
    enable = true;
    apps = [ "photocraft" "wordcraft" "gridcraft" ];
  };
}
```

<details>
<summary>Complete standalone Home Manager flake</summary>

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    artcraft.url = "github:J0schu/artcraft.nix";
  };

  outputs = { nixpkgs, home-manager, artcraft, ... }: {
    homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux; # or aarch64-linux
      modules = [
        artcraft.homeManagerModules.default
        {
          home = {
            username = "me";
            homeDirectory = "/home/me";
            stateVersion = "26.05";
          };
          programs.artcraft = {
            enable = true;
            apps = [ "photocraft" "wordcraft" ];
          };
        }
      ];
    };
  };
}
```

Apply with `home-manager switch --flake .#me`.

</details>

`apps` accepts any package name from the table

### NixOS

Same options, system-wide:

```nix
imports = [ inputs.artcraft.nixosModules.default ];
programs.artcraft = { 
  enable = true;
  apps = [ "photocraft" ];
};
```

### Without the modules

```nix
# packages
environment.systemPackages = [ inputs.artcraft.packages.${pkgs.stdenv.hostPlatform.system}.photocraft ];

# or via the overlay: nixpkgs.overlays = [ inputs.artcraft.overlays.default ];
environment.systemPackages = [ pkgs.artcraft.photocraft ];
```

### nix run

Try an app:

```sh
nix run github:J0schu/artcraft.nix#photocraft
nix run github:J0schu/artcraft.nix#wordcraft -- path/to/file   # arguments are passed through
```
