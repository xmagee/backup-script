#!/bin/bash

while getopts s:d: flag
do
    case "${flag}" in
        s) source_arg=${OPTARG};;
        d) dest_arg=${OPTARG};;
    esac
done

if [ ${#source_arg} ==  0 ] 
    then
        echo "source dir required"
        exit
fi 

if [ ${#dest_arg} ==  0 ] 
    then 
        echo "destination dir required" 
        exit
fi

source="$source_arg"
dest=""

if [ "${dest_arg: -1}" == "/"  ] 
    then dest+=${dest_arg%?}
    else dest+=dest_arg
fi

dest+="/$(date +'%Y')/$(date +%m)/$(date +%d)/$(date '+%s')/"

[ ! -d "$source" ] && echo "source dir does not exist"

[ ! -d "$dest" ] &&  mkdir -p "$dest"

echo ""

echo "starting backup:"
echo "source dir: $source"
echo "destination dir: $dest"

echo ""

rsync -a -r -v --rsync-path="mkdir -p $dest && rsync" $source $dest

echo ""

echo "backup complete :)"

echo ""
