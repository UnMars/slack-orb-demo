#!/bin/bash

# Set environment variables
export CIRCLE_PROJECT_REPONAME="$CIRCLE_PROJECT_REPONAME"
export CIRCLE_BRANCH="$CIRCLE_BRANCH"
export CIRCLE_BUILD_URL="$CIRCLE_BUILD_URL"
export CIRCLE_BUILD_NUM="$CIRCLE_BUILD_NUM"

# Execute script
/tmp/slack-notify.sh "$1" "$2" "$3" "$4" "$5"
