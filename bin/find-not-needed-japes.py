#!/usr/bin/env python

import sys
import os
import os.path

DEBUG=True
declared_phases = set()

def add_phases_from(main_phase):
    declared_phases.add(main_phase)

    phases_declaration_started = False
    for line in open(main_phase):
        if phases_declaration_started:
            declared_phases.add(line.strip() + '.jape')
        if 'Phases:' in line:
            phases_declaration_started = True


for arg in sys.argv[1:]:
    add_phases_from(arg)

files_in_dir = set(os.listdir('.'))

for f in files_in_dir - declared_phases:
    print("File %s can be removed as it isn't declared in %s" % (f, sys.argv[1:]))
