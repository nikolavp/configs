import re

# Mapping for gmail
mapping = { 'INBOX'             : 'INBOX'
          , '[Gmail]/Drafts'    : 'drafts'
          , '[Gmail]/Sent Mail' : 'sent_mail'
          , '[Gmail]/Trash'     : 'trash'
          }

r_mapping = { val: key for key, val in mapping.items() }

def nt_remote(folder):
    if folder in mapping:
        return mapping[folder]
    return folder

def nt_local(folder):
    if folder in r_mapping:
        return r_mapping[folder]
    return folder

def exclude(excludes):
    def inner(folder):
        return folder not in excludes
    return inner

def include(includes):
    def inner(folder):
        return folder in includes
    return inner
