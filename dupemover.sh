#!/bin/bash

dpkg -s 'fdupes' &> /dev/null

if [ $? -ne 0 ]; then
    echo "fdupes is not installed but is required!"
    exit 1
fi

source_path=$1
dest_path=$2
dupelist='dupelist'

# Make sure user gave source_path                                                                                                                                                                           
if [ -z $source_path ]; then
    echo "You need to give me an source path and a destination path."
    echo "Something like 'dupe.sh <path/to/source/folder> <path/to/destination/folder>.'"
    echo "Thanks."
    exit 1
fi

# Make sure source_path is real                                                                                                                                                                             
if ! [ -d "$source_path" ]; then
    echo "That source path isn't a real directory"
    exit 1
fi

# Make sure user gave dest_path                                                                                                                                                                             
if [ -z $dest_path ]; then
    echo "You need to give me an source path and a destination path."
    echo "Something like 'dupe.sh <path/to/source/folder> <path/to/destination/folder>.'"
    echo "Thanks."
    exit 1
fi

# Make sure dest_path is real                                                                                                                                                                               
if ! [ -d "$dest_path" ]; then
    echo "That output path isn't a real directory"
    exit 1
fi

# Make sure dest_path ends with /                                                                                                                                                                           
[[ "$dest_path" != */ ]] && dest_path="${dest_path}/"

# Make dupelist file                                                                                                                                                                                        
touch $dupelist #create file 'dupelist'                                                                                                                                                                     
fdupes -rf $source_path > $dupelist #write 2nd+ dupes to file 'dupelist'                                                                                                                                    
sed -i '/^$/d' $dupelist #remove blank lines                                                                                                                                                                

n=1
while read line; do
    NAME=${line##*/}
    PATH=${line%/*}
    NEWNAME="${n}${NAME}"
    NEWFILE="${dest_path}${NEWNAME}"
#    echo $NEWFILE
    mv $line $NEWFILE                                                                                                                                                                                      
    n=$((n+1))
    done < $dupelist
