 { stdenv, lib
, fetchurl
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "mta-sa-server";
  version = "1.3";

  src = fetchurl {
    url = "https://linux.multitheftauto.com/dl/multitheftauto_linux_x64.tar.gz";
    hash = "sha256-4CkijAlenhht8tyk3nBULaBPE0GBf6DVII699/RmmWI=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    tar -xf multitheftauto_linux_x64.tar.gz
    wget https://linux.multitheftauto.com/dl/baseconfig.tar.gz
    tar -xf baseconfig.tar.gz
    mv baseconfig/\* multitheftauto_linux_x64/mods/deathmatch
    cd multitheftauto_linux_x64
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D studio-link-standalone-v${version} $out/bin/studio-link
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://studio-link.com";
    description = "Voip transfer";
    platforms = platforms.linux;
  };
}