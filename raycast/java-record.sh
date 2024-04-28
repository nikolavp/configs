#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title java-record
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Print a java record in a human readable way
# @raycast.author Nikola Petrov
# @raycast.authorURL https://github.com/nikolavp

pbpaste | ../bin/java-record

