#!/bin/bash

# 

SOURCE=$1
TAG=$2
DEST=input/$TAG

if [ "$TAG" == "" ]  || [ "$SOURCE" == "-h" ]; then
    echo Extracts relevant data from a proceedings tar ball or proceedings directory.
    echo "usage $0 <source directory or tarball> <conference part tag>"
fi

mkdir -p $DEST

if [ -d $SOURCE ]; then
    rsync $SOURCE/final --filter="*metadata.txt" $DEST
    rsync $SOURCE/order $DEST
else
    if [[ $SOURCE == *.tgz ]] || [[ $SOURCE == *.tar.gz ]]; then
	z=z
    elif [[ $SOURCE == *.tar.bz2 ]]; then
	z=j
    fi
    #echo tar -C $DEST t${z}f $SOURCE --wildcards proceedings/final/*/*metadata.txt proceedings/order 
    tar x${z}f $SOURCE -C $DEST --wildcards proceedings/final/*/*metadata.txt proceedings/order 
    #mv $DEST/proceedings/final $DEST
    #mv $DEST/proceedings/order $DEST
    #rmdir $DEST/proceedings
fi
