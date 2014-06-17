#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :
# The documentation is written in confluence wiki syntax

echo '{toc}'
# Get the documentation without any warnings
puppet doc manifests/* 2> /dev/null
