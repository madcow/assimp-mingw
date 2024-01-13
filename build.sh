#!/bin/bash

# Cross-compile assimp with x86_64-mingw-w64
# Written by Leon Krieg <info@madcow.dev>

set -e
set -o nounset

ROOTDIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

TMPDIR=$ROOTDIR/build
OPTDIR=$ROOTDIR/external
INCLUDEDIR=$ROOTDIR/include
LIBDIR=$ROOTDIR/lib

TOOLCHAIN=$OPTDIR/polly/linux-mingw-w64-gnuxx11.cmake
CXXFLAGS="-Wno-array-bounds -Wno-alloc-size-larger-than -Wno-error=array-compare"

mkdir -p "$TMPDIR" "$LIBDIR" "$INCLUDEDIR"
cd "$TMPDIR"

cmake \
	-DCMAKE_INSTALL_PREFIX="$ROOTDIR"            \
	-DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN"          \
	-DBUILD_SHARED_LIBS=OFF                      \
	-DASSIMP_BUILD_TESTS=OFF                     \
	-DASSIMP_NO_EXPORT=ON                        \
	-DASSIMP_BUILD_ZLIB=ON                       \
	-DASSIMP_INSTALL_PDB=OFF                     \
	-DCMAKE_CXX_FLAGS="$CXXFLAGS"                \
	-DASSIMP_BUILD_ALL_IMPORTERS_BY_DEFAULT=OFF  \
	-DASSIMP_BUILD_FBX_IMPORTER=ON               \
	"$OPTDIR/assimp"

make all install
rm -rf "$LIBDIR"/{cmake,pkgconfig}
echo "Build was successful."
