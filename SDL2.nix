{ stdenv, fetchurl, androidndk, ndkWrapper }:

stdenv.mkDerivation rec {
    iname = "SDL2";
    version = "2.0.3";
    suffix = "androidndk";
    name = iname + "-" + suffix + "-" + version;

    src = fetchurl {
    url = "https://www.libsdl.org/release/${iname}-${version}.tar.gz";
    sha256 = "b0af5f12ce10fca0ec54b485cd01cc9addfdbee467b6cb51ec4d5142df8d35ce";
    };
  configureFlags = [ "--host=arm"
                     "--enable-static"
                     "--disable-shared"
                     "--without-manpages"
                     "--without-debug"
		                 "--without-cxx" ];

  buildInputs = [];
  phases = [ "unpackPhase" "configurePhase" "buildPhase" "installPhase" ];
  preConfigure = ''
    export NDK=${androidndk}/libexec/android-ndk-r10c/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
    export NDK_TARGET=arm-linux-androideabi
    export CC=${ndkWrapper}/bin/$NDK_TARGET-gcc
    export LD=${ndkWrapper}/bin/$NDK_TARGET-ld
    export RANLIB=${ndkWrapper}/bin/$NDK_TARGET-gcc-ranlib
    export STRIP=${ndkWrapper}/bin/$NDK_TARGET-strip
    export NM=${ndkWrapper}/bin/$NDK_TARGET-gcc-nm
    export AR=${ndkWrapper}/bin/$NDK_TARGET-gcc-ar
  '';

  enableParallelBuilding = true;

  doCheck = false;
}

