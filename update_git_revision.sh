#!/bin/sh
LAST_COMMIT_SHA=$(git rev-parse HEAD | cut -c 1-8)
echo "#define GIT_REV "\"$LAST_COMMIT_SHA\" > gamemodes/revision.inc
