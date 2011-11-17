#!/usr/bin/env python
# vim: set sw=4 sts=4 et foldmethod=indent :

import dbus
import sys

ACCOUNTMANAGER_PATH = "/org/freedesktop/Telepathy/AccountManager"
ACCOUNTMANAGER_IFACE = "org.freedesktop.Telepathy.AccountManager"
ACCOUNT_IFACE = "org.freedesktop.Telepathy.Account"
CHANNEL_GROUP_IFACE = "org.freedesktop.Telepathy.Channel.Interface.Group"
CONTACT_IFACE = "org.freedesktop.Telepathy.Connection.Interface.Contacts"
SIMPLE_PRESENCE_IFACE = "org.freedesktop.Telepathy.Connection.Interface.SimplePresence"
DBUS_PROPS_IFACE = "org.freedesktop.DBus.Properties"
CHANNELDISPATCHER_IFACE = "org.freedesktop.Telepathy.ChannelDispatcher"
CHANNELDISPATCHER_PATH = "/org/freedesktop/Telepathy/ChannelDispatcher"
CHANNEL_TYPE = "org.freedesktop.Telepathy.Channel.ChannelType"
CHANNEL_TYPE_TEXT = "org.freedesktop.Telepathy.Channel.Type.Text"
CHANNEL_TARGETHANDLE = "org.freedesktop.Telepathy.Channel.TargetHandle"
CHANNEL_TARGETHANDLETYPE = "org.freedesktop.Telepathy.Channel.TargetHandleType"
EMPATHY_CLIENT_IFACE = "org.freedesktop.Telepathy.Client.Empathy"

_STATUSES = {
    'available':    'Available',
    'away':         'Away',
    'dnd':          'Busy',
    'xa':           'Not Available',
    'hidden':       'Invisible',
    'offline':      'Offline'
}

_ATTRIBUTES = {
    'alias':          'org.freedesktop.Telepathy.Connection.Interface.Aliasing/alias',
    'presence':       'org.freedesktop.Telepathy.Connection.Interface.SimplePresence/presence',
    'contact_caps':   'org.freedesktop.Telepathy.Connection.Interface.ContactCapabilities.DRAFT/caps',
    'jid':            'org.freedesktop.Telepathy.Connection/contact-id',
    'caps':           'org.freedesktop.Telepathy.Connection.Interface.Capabilities/caps',
}
def _create_dbus_connection():
        sbus = dbus.SessionBus()
        proxy_obj = sbus.get_object(ACCOUNTMANAGER_IFACE, ACCOUNTMANAGER_PATH)
        dbus_iface = dbus.Interface(proxy_obj, DBUS_PROPS_IFACE)
        return dbus_iface

def activate(status):
    if status not in _STATUSES.keys():
        raise ValueError("Invalid status: "+ status)

    bus = dbus.SessionBus()
    interface = _create_dbus_connection()
    for valid_account in interface.Get(ACCOUNTMANAGER_IFACE, "ValidAccounts"):
        account = bus.get_object(ACCOUNTMANAGER_IFACE, valid_account)
        connection_status = account.Get(ACCOUNT_IFACE, "ConnectionStatus")
        if connection_status != 0:
            continue

        #if status == "offline":
        #    false = dbus.Boolean(0, variant_level=1)
        #    account.Set(ACCOUNT_IFACE, "Enabled", false)
        #else:
        connection_path = account.Get(ACCOUNT_IFACE, "Connection")
        connection_iface = connection_path.replace("/", ".")[1:]
        connection = bus.get_object(connection_iface, connection_path)
        simple_presence = dbus.Interface(connection, SIMPLE_PRESENCE_IFACE)
        try:
            simple_presence.SetPresence(status, _STATUSES.get(status))
        except dbus.exceptions.DBusException:
            print(status + ' is not supported by ' + valid_account)

status = sys.argv[1].lower()

activate(status)
