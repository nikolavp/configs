#!/usr/bin/env python
# vim: set sw=4 sts=4 et foldmethod=indent :

import os
from pyinotify import WatchManager, Notifier, ThreadedNotifier, ProcessEvent, ExcludeFilter
from subprocess import Popen, PIPE
import pyinotify
import os.path
import os, re

excludes = ExcludeFilter("/home/nikolavp/excludes")
wm = WatchManager(exclude_filter = excludes)
mask = pyinotify.IN_CLOSE_WRITE

class PyWatchEventProcessor(ProcessEvent):
    def __init__(self):
        self.rules = {}
    def process_default(self, event):
        if excludes(event.name):
            return
        modified_filename = os.path.join(event.path, event.name)
        for pattern, function in self.rules.items():
            matcher = pattern.match(modified_filename)
            if matcher:
                function(matcher)
    def addRule(self,regexp_str, func):
        pattern = re.compile(regexp_str)
        self.rules[pattern] = func

class JavaProcessor(object):
    def __init__(self, test_dir):
        self.test_dir = test_dir

    @staticmethod
    def run_java_tests(tests_to_run, event_file):
        if tests_to_run:
            print("No tests to run after " + event_file + " was changed")
            return
        execute_list_string = ['java',  'org.junit.runner.JUnitCore']
        execute_list_string.extend(tests_to_run)
        print("Executing tests " + ",".join(tests_to_run))
        output = Popen(execute_list_string, stdout=PIPE).communicate()[0]
        print(output)

    def __call__(self, matcher):
        self.package_dir = matcher.group("package_dir")
        self.modified_classname = matcher.group("classname")
        tests_to_run = self.get_suitable_tests_to_run()
        JavaProcessor.run_java_tests(tests_to_run, self.modified_classname)
    def get_suitable_tests_to_run(self):
        current_tests_dir = os.path.join(self.test_dir, self.package_dir)
        if not os.path.exists(current_tests_dir):
            print("Couldn't find the test directory " + current_tests_dir)
            return
        files = os.listdir(current_tests_dir)
        test_classes =  []
        for f in files:
            if f.rfind(self.modified_classname) != -1:
                package = package.dir.replace("/", ".")
                test_classname, ext = os.path.splitext(f)
                test_classes.append(package + "." + test_classname)
        return test_classes





event_processor = PyWatchEventProcessor()

def watch(regexp, function):
    event_processor.addRule(regexp, function)

if __name__ == '__main__':
    notifier = Notifier(wm, event_processor)
    dd = wm.add_watch(".", mask, rec=True)
    watch("src/(?P<package_dir>.*)/(?P<classname>.*?)\.java", JavaProcessor("test/java"))
    notifier.loop()
