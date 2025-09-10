#!/bin/bash

# Set environment variables
export CIRCLE_PROJECT_REPONAME="$CIRCLE_PROJECT_REPONAME"
export CIRCLE_BRANCH="$CIRCLE_BRANCH"
export CIRCLE_BUILD_URL="$CIRCLE_BUILD_URL"
export CIRCLE_BUILD_NUM="$CIRCLE_BUILD_NUM"

# Execute script with environment variables
/tmp/slack-notify.sh "$STATUS" "$TARGET" "$MESSAGE" "$MENTION" "$WEBHOOK"
