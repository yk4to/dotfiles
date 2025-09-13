{
  stdenv,
  lib,
  alsa-lib,
  atk,
  at-spi2-atk,
  cairo,
  cups,
  dbus,
  dpkg,
  expat,
  fontconfig,
  freetype,
  fetchurl,
  gdk-pixbuf,
  glib,
  gtk2,
  gtk3,
  libpulseaudio,
  makeWrapper,
  nspr,
  nss,
  pango,
  udev,
  xorg,
  libuuid,
  at-spi2-core,
  libsecret,
  coreutils,
  libdrm,
  libgbm,
  libxkbcommon,
  libGL,
}: let
  version = "5.11.6";

  deps = [
    libuuid
    libsecret
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk2
    gtk3
    libpulseaudio
    nspr
    nss
    pango
    stdenv.cc.cc
    udev
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXtst
    xorg.libxkbfile
    libdrm
    libgbm
    libxkbcommon
    libGL
  ];
in
  stdenv.mkDerivation {
    pname = "inkdrop";
    inherit version;

    src = fetchurl {
      url = "https://d3ip0rje8grhnl.cloudfront.net/v${version}/inkdrop_${version}_amd64.deb";
      hash = "sha256-AdimOAnWxLk5Z4X5YKrlWrxl1miR0Cs8CvIzC5wUKWw=";
    };

    dontBuild = true;
    buildInputs = [
      dpkg
      makeWrapper
    ];

    unpackPhase = ''
      dpkg --fsys-tarfile $src | tar --extract
    '';

    installPhase = ''
      rm -r ./usr/share/lintian
      rm -r ./usr/share/doc

      mkdir -p $out
      cp -r ./usr/share $out
      cp -r ./usr/bin $out
      cp -r ./usr/lib $out

      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
               "$out/lib/inkdrop/inkdrop"

      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
               "$out/lib/inkdrop/resources/app/ipm/bin/node"

      wrapProgram $out/lib/inkdrop/inkdrop \
        --prefix LD_LIBRARY_PATH : "$out/lib/inkdrop" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath deps}"

      wrapProgram $out/lib/inkdrop/resources/app/ipm/bin/ipm \
        --prefix PATH : "${coreutils.out}/bin" \
        --prefix LD_LIBRARY_PATH : "$out/lib/inkdrop" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath deps}"

      mkdir -p $out/bin
      makeWrapper $out/lib/inkdrop/resources/app/ipm/bin/ipm $out/bin/ipm \
        --prefix PATH : "${coreutils.out}/bin" \
        --prefix LD_LIBRARY_PATH : "$out/lib/inkdrop" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath deps}"
    '';

    meta = {
      homepage = "https://www.inkdrop.app/";
      description = "Organizing your Markdown notes made simple";
      license = lib.licenses.unfreeRedistributable;
      platforms = ["x86_64-linux"];
      maintainers = [lib.maintainers.cstrahan];
    };
  }
