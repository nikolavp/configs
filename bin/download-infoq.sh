#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

export PATH=~/Downloads/ffmpeg-git-20160205-64bit-static:$PATH

infoqscraper presentation download -t h264_overlay $@
