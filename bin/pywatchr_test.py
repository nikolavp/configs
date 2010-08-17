#!/usr/bin/env python
# vim: set sw=4 sts=4 et foldmethod=indent :


import unittest


class DummyClass(object):
    pass



package_classname_pattern = "src/main/java/(?P<package_dir>.*/)(?P<classname>.*?)\.java"
event_dict = {'path' :
        'src/main/java/com/ontotext', 'name' : 'Hello.java'}

d = DummyClass()
d.__dict__ = event_dict
from pywatchr import PyWatchEventProcessor
class PyWatchEventProcessorTest(unittest.TestCase):
    def setUp(self):
        self.processor = PyWatchEventProcessor()
    def test_that_we_only_accept_regexp(self):
        def f(matcher):
            f.called = True
        f.called = False
        self.processor.addRule(package_classname_pattern, f)
        self.processor.process_default(d)
        self.assertTrue(f.called)
    def test_that_we_get_the_matcher_object(self):
        def matcher_validator(matcher):
            self.assertTrue(matcher.group(1))
            self.assertEquals("com/ontotext/", matcher.group("package_dir"))
            self.assertEquals("Hello", matcher.group("classname"))
        self.processor.addRule(package_classname_pattern, matcher_validator)
        self.processor.process_default(d)


if __name__ == '__main__':
    unittest.main()
