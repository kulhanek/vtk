#!/bin/bash

MODE=$1
if [ -z "$MODE" ]; then
    MODE="quick"
fi

case $MODE in
    "quick")
		# nothing to be here
		echo "Nothing done ..."
    ;;
    "deep")
        rm -rf `find . -name CMakeFiles`
        rm -rf `find . -name CMakeCache.txt`
        rm -rf `find . -name cmake_install.cmake`
        rm -rf `find . -name Makefile`
        rm -rf `find . -name 'VTK-6.3.0*'`
        rm -rf build
        rm -rf src/build
    ;;
esac

