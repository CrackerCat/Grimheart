#!/usr/bin/env bash
set -e
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export CC=/Library/Developer/Toolchains/Luminescent.xctoolchain/usr/bin/clang
export CXX=/Library/Developer/Toolchains/Luminescent.xctoolchain/usr/bin/clang++
export CFLAGS="-mllvm -MaxProt"
export CXXFLAGS="-mllvm -MaxProt"
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
echo "Script Root: $DIR"
rm -rf $DIR/build/
mkdir $DIR/build/

cd $DIR/build/
cmake $DIR -DCMAKE_BUILD_TYPE=Release
cmake --build .
