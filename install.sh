echo "installing vapory and patched version of povray and megapov"
echo "installing vapory"
sudo pip install vapory

echo "need to install libboost to compile vlpoutils"
sudo apt-get install libboost-dev libboost-test-dev

echo "creating folder where thirparties will be downloaded and compiled"
mkdir thirdparties 
cd thirdparties 

echo "dwonloading all thirdparties" 
wget http://github.com/devernay/vlpovutils/archive/71890a3acc8501f674795285aa69669f15c95f69/master.zip --no-check-certificate -O vlpovutils.zip
wget http://sourceforge.net/projects/libpng/files/libpng15/1.5.26/libpng-1.5.26.tar.gz
wget http://megapov.inetart.net/packages/unix/megapov-1.2.1.tgz
wget http://www.povray.org/ftp/pub/povray/Old-Versions/Official-3.62/Unix/povray-3.6.1.tar.bz2

echo "download vlpovutils which containes the patches to apply to povray and megaov"
unzip vlpovutils.zip 
rm vlpovutils.zip
mv vlpovutils-71890a3acc8501f674795285aa69669f15c95f69 vlpovutils


echo "installing libpng1.5 locally"

tar xf libpng-1.5.26.tar.gz 
cd libpng-1.5.26
./configure --prefix=$PWD/../libpng15
make check
make install
cd ..


echo "installing povray 3.6.1 locally, assumin glibpng is the library installed in the system"
tar -jxjf povray-3.6.1.tar.bz2
cd povray-3.6.1/
./configure --prefix=$PWD/../megapov --with-x COMPILED_BY="martin.de-la-gorce@enpc.fr" 
make
make install 
sed -i 's/;none /none /g' $PWD/../megapov/etc/povray/3.6/povray.conf
sed -i 's/restricted /;restricted /g' $PWD/../megapov/etc/povray/3.6/povray.conf
cd ..



echo "installing patched megapov 1.2.1"
tar -zxvf megapov-1.2.1.tgz
cd megapov-1.2.1/
patch -p1  < ../vlpovutils/povray/megapov-annotation-0.2.patch 
patch -p1 < ../vlpovutils/povray/megapov-focalblur.patch
patch -p1 < ../megapov-png15.patch
export CPPFLAGS=-I$PWD/../libpng15/include
export LDFLAGS=-L$PWD/../libpng15/lib
./configure --prefix=$PWD/../megapov --with-x COMPILED_BY="martin.de-la-gorce@enpc.fr"  --disable-lib-checks
make 
make install
cd ..


echo "compilling and modifying megapov default configuration files"
sed -i 's/;none /none /g' $PWD/megapov/etc/megapov/1.2.1/povray.conf
sed -i 's/restricted /;restricted /g' $PWD/megapov/etc/megapov/1.2.1/povray.conf
sed -i '$ a\ Library_Path="'${PWD}'/megapov/share/povray-3.6"' $PWD/megapov/etc/megapov/1.2.1/povray.ini
sed -i '$ a\ Library_Path="'${PWD}'/megapov/share/povray-3.6/ini"' $PWD/megapov/etc/megapov/1.2.1/povray.ini
sed -i '$ a\ Library_Path="'${PWD}'/megapov/share/povray-3.6/include"' $PWD/megapov/etc/megapov/1.2.1/povray.ini

cp ./megapov/etc/megapov/1.2.1/povray.ini ~/.megapov/1.2.1/povray.ini
cp ./megapov/etc/megapov/1.2.1/povray.conf ~/.megapov/1.2.1/povray.conf

echo "installing vlpovutils"
cd vlpovutils
sed -i 's/CXXFLAGS=/CXXFLAGS= -std=c++11 /g' Makefile   
make
cd ..
cd ..
cp ./thirdparties/megapov/bin/megapov megapov
cp ./thirdparties/vlpovutils/vlpov_motionfield2 vlpov_motionfield2
