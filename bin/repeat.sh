#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

set -o nounset
set -o errexit

for x in {1..20} ; do
    $1 &> ${x}-output.txt
done
