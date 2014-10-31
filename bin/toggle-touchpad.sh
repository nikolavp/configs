#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :
# Sometimes synclient TouchpadOff=1 doesn't work on lenovo.
# Toggle the touchpad with xinput instead...

declare -i ID
ID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
declare -i STATE
STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`
if [ $STATE -eq 1 ]
then
    xinput disable $ID
    echo "Touchpad disabled."
else
    xinput enable $ID
    echo "Touchpad enabled."
fi
