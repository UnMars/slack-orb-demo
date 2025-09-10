#!/bin/bash

# Determine emoji and color based on status
case "$1" in
  "success")
    EMOJI="✅"
    COLOR="good"
    ;;
  "failure")
    EMOJI="❌"
    COLOR="danger"
    ;;
  "warning")
    EMOJI="⚠️"
    COLOR="warning"
    ;;
  "info")
    EMOJI="ℹ️"
    COLOR="#36a64f"
    ;;
  *)
    EMOJI="📢"
    COLOR="#36a64f"
    ;;
esac

# Build mention string
MENTION_STRING=""
if [ -n "$4" ]; then
  MENTION_STRING="$4 "
fi

# Create JSON payload with targeted message
PAYLOAD=$(cat <<EOF
{
  "channel": "$2",
  "username": "CircleCI Bot",
  "icon_emoji": ":robot_face:",
  "text": "${MENTION_STRING}${EMOJI} $3",
  "attachments": [
    {
      "color": "$COLOR",
      "fields": [
        {
          "title": "Status",
          "value": "$1",
          "short": true
        },
        {
          "title": "Project",
          "value": "$CIRCLE_PROJECT_REPONAME",
          "short": true
        },
        {
          "title": "Branch",
          "value": "$CIRCLE_BRANCH",
          "short": true
        },
        {
          "title": "Build",
          "value": "<$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM>",
          "short": true
        }
      ],
      "footer": "CircleCI",
      "ts": $(date +%s)
    }
  ]
}
EOF
)

# Send notification
curl -X POST -H 'Content-type: application/json' \
  --data "$PAYLOAD" \
  "$5"
