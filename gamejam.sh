#!/bin/sh

mkdir -p prefix
PREFIX="$(pwd)/prefix"

wget 'cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.xz'
tar -xJf 'ruby-2.4.2.tar.xz'

cd 'ruby-2.4.2'
./configure --prefix="$PREFIX" --disable-install-doc

make -j4 install

# Gosu dependencies
sudo apt install libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libopenal-dev libsndfile1-dev libmpg123-dev libgmp-dev
cd '../prefix'
./bin/gem install gosu
sudo apt remove libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libopenal-dev libsndfile1-dev libmpg123-dev libgmp-dev

cd '..'
rm -rf 'ruby-2.4.2'
rm -rf 'ruby-2.4.2.tar.xz'

