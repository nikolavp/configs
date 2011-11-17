#!/usr/bin/env python
# vim: set sw=4 sts=4 et foldmethod=indent :
#A script to change the current skype status.
#
#@author Nikola Petrov<nikolavp@gmail.com>
#
#check the documentation at http://developer.skype.com/public-api-reference#Linux
#for information on the skype protocol while communicating with dbus.

import dbus
import sys

status sys.argv[1].upper()

bus = dbus.SessionBus()
bus.get_object('com.Skype.API', '/com/Skype')
proxy = bus.get_object('com.Skype.API', '/com/Skype')


response = proxy.Invoke('NAME pyscript')
if response !=  'OK':
    print('Error while communicating with skype ')
response = proxy.Invoke('PROTOCOL 7')
if response != 'PROTOCOL 7':
    print('Error while doing the protocol handshaking with skype')
response = proxy.Invoke('SET USERSTATUS ' + status)
if response != 'USERSTATUS ' + status:
    print("Couldn't change the skype status to away")

