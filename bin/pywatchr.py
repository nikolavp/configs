#!/usr/bin/env python
# vim: set sw=4 sts=4 et foldmethod=indent :

import os
from pyinotify import WatchManager, Notifier, ThreadedNotifier, ProcessEvent, ExcludeFilter
from subprocess import Popen, PIPE
import pyinotify
import os.path
import os


excludes = ExcludeFilter("/home/nikolavp/excludes")
wm = WatchManager(exclude_filter = excludes)
test_dir = 'test/java'
prefix = 'src'
event_names = []


mask = pyinotify.IN_CLOSE_WRITE


class PyWatchEventProcessor(ProcessEvent):
    def process_default(self, event):
        if excludes(event.name):
            return
        call_tests(event.path, event.name)

def get_current_package(event_path, remove_prefix):
    dirs = []
    path = event_path
    while path != remove_prefix:
        path, d = os.path.split(path)
        dirs.insert(0, d)
    if dirs:
        return os.path.join(*dirs)
    else:
        return ""

def call_tests(event_path, event_file):
    current_package = get_current_package(event_path, prefix)

    current_tests_dir = os.path.join(test_dir, current_package)
    if not os.path.exists(current_tests_dir):
        print("Couldn't find test package " + current_tests_dir)
        return
    tests_to_run = get_suitable_tests_to_run(current_tests_dir, event_file)

    if tests_to_run is None:
        print("No tests to run after " + event_file + " was changed")
        return
    execute_list_string = ['java',  'org.junit.runner.JUnitCore']
    execute_list_string.extend(tests_to_run)
    print("Starting tests " + ",".join(tests_to_run))
    output = Popen(execute_list_string, stdout=PIPE).communicate()[0]
    print(output)

def get_suitable_tests_to_run(current_tests_dir, modified_class):
    files = os.listdir(current_tests_dir)
    modified_class_name, extensions = os.path.splitext(modified_class)
    test_class = None
    for f in files:
        if f.rfind(modified_class_name) != -1:
            test_class, ext = os.path.splitext(f)
            break
    if test_class:
        test_class = test_package + "." + test_class
        test_class_name = test_class.replace("/", ".")
        return [test_class_name]


def process_all_events(d):
    notifier = Notifier(wm, PyWatchEventProcessor())
    dd = wm.add_watch(d, mask, rec=True)
    notifier.loop()


import sys
if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Please provide at least the directory to watch")
        sys.exit(1)
    process_all_events(sys.argv[1])
