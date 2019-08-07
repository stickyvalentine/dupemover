# dupemover
Find and move duplicate files into a separate directory

dupemover.sh <path/to/source/directory> <path/to/destination/directory>

Dupemover needs a path to a source directory and a path to a destination directory. The source directory will be recursively searched for duplicate files using fdupes. One copy of each file will be left in place while duplicates will be moved to the destination directory. A file called dupelist will be created in the directory the script was run from that lists the original locations of every file moved.
