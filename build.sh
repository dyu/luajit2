#!/bin/sh

CURRENT_DIR=$PWD
# locate
if [ -z "$BASH_SOURCE" ]; then
    SCRIPT_DIR=`dirname "$(readlink -f $0)"`
elif [ -e '/bin/zsh' ]; then
    F=`/bin/zsh -c "print -lr -- $BASH_SOURCE(:A)"`
    SCRIPT_DIR=`dirname $F`
elif [ -e '/usr/bin/realpath' ]; then
    F=`/usr/bin/realpath $BASH_SOURCE`
    SCRIPT_DIR=`dirname $F`
else
    F=$BASH_SOURCE
    while [ -h "$F" ]; do F="$(readlink $F)"; done
    SCRIPT_DIR=`dirname $F`
fi
# change pwd
cd $SCRIPT_DIR

# Usage:
# ./build.sh && ./build.sh install

UNAME=`uname`
if [ "$UNAME" = "Darwin" ]; then
    VER=`sw_vers --productVersion`
    MV="${VER%%.*}"
    export MACOSX_DEPLOYMENT_TARGET=$MV
fi
make PREFIX=/opt/luajit $@
