#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

DIR=/backup
FILE=${DIR}/$(/bin/date -I)_data
# Commands
dar -zlzo -D -R /home/gerucio -c $FILE -Z "*.gz" \
   -Z "*.bz2" -Z "*.zip" -Z "*.png" > /dev/null
dar -t $FILE > /dev/null
