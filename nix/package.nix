{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
}:

{
  name,
  version,
  hashes,
  description,
}:

let
  inherit (stdenv.hostPlatform) system;

  arch =
    {
      x86_64-linux = "x86_64";
      aarch64-linux = "aarch64";
    }
    .${system}
      or (throw "artcraft: ${system} is not supported (AppImages exist for x86_64 and aarch64 Linux)");

  id = "ai.storyteller.${name}";

  src = fetchurl {
    url = "https://github.com/storytold/${name}/releases/download/v${version}/${name}-${version}-linux-${arch}.AppImage";
    hash = hashes.${system};
  };

  contents = appimageTools.extract {
    inherit src version;
    pname = name;
  };
in
appimageTools.wrapType2 {
  inherit version src;
  pname = name;

  extraPkgs = pkgs: [ pkgs.libva ];

  extraInstallCommands = ''
    install -Dm444 ${contents}/${id}.desktop -t $out/share/applications
    install -Dm444 ${contents}/usr/share/mime/packages/${id}.xml -t $out/share/mime/packages
    install -Dm444 ${contents}/usr/share/metainfo/${id}.metainfo.xml -t $out/share/metainfo
    cp -r --no-preserve=mode ${contents}/usr/share/icons $out/share/
  '';

  meta = {
    inherit description;
    homepage = "https://getartcraft.com/apps/${name}";
    downloadPage = "https://github.com/storytold/${name}/releases";
    license = with lib.licenses; [
      mit
      asl20
    ];
    mainProgram = name;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
