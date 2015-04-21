#!/bin/bash -ex

function cleanup() {
    rm -Rf $TMPDIR
}

#get script location
SCRIPTDIR=`dirname $0`
SCRIPTDIR=`(cd $SCRIPTDIR ; pwd)`

#create tmp dir
TMPDIR=`mktemp -d -t umeq_build_static_XXXXXXXX`
trap cleanup EXIT
#get and build umeq
cd ${TMPDIR}
git clone https://github.com/mickael-guene/umeq.git
cd umeq
mkdir build
cd build
cmake ..
make all
make test
strip src/umeq-arm
strip src/umeq-arm64
#copy file
cp src/umeq-arm ${SCRIPTDIR}/../bin/.
cp src/umeq-arm64 ${SCRIPTDIR}/../bin/.

