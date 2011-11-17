#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :


export MOZILLA_DIST=/home/nikolavp/workspace/joci/joci-lib/lib/mozillaparser
#Stupid settigs come from this and firefox is complaining so set it as a local
#script
LD_LIBRARY_PATH="$MOZILLA_DIST:$MOZILLA_DIST/mozilla" /home/nikolavp/Desktop/new-eclipse/eclipse/eclipse

