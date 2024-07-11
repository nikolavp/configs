#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title bound-linear
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Open the ticket id in linear
# @raycast.author Nikola Petrov
# @raycast.authorURL https://github.com/nikolavp

open https://linear.app/bound/issue/$(pbpaste)

