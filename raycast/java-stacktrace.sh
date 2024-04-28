#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title java-stacktrace
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Show java stacktrace in a beautiful form
# @raycast.author Nikola Petrov
# @raycast.authorURL https://github.com/nikolavp


pbpaste | ../bin/beautify-stacktrace

