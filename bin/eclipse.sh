#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :


export MOZILLA_DIST=/home/nikolavp/onto-dist
#Stupid settigs come from this and firefox is complaining so set it as a local
#script
LD_LIBRARY_PATH="$MOZILLA_DIST:$MOZILLA_DIST/mozilla" /home/nikolavp/Desktop/eclipse/eclipse

