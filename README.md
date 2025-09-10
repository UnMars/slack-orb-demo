# Slack Notification Orb for CircleCI

A simple and powerful Slack notification orb for CircleCI. Send targeted notifications to specific people, teams, or channels with customizable messages and build status.

## Features

- 🎯 **Targeted notifications**: Send to specific people (@username), teams (@channel), or channels (#channel)
- 🎨 **Rich formatting**: Customizable messages with emojis and colors
- 📊 **Build context**: Automatic inclusion of project, branch, and build information
- 🔧 **Flexible**: Easy to customize and extend
- 📱 **Real-time**: Instant notifications for your team
- 💬 **Mentions**: Additional mentions for specific teams or people

## Usage

### Basic Usage

```yaml
version: 2.1

orbs:
  notification: unmars/slack-orb-demo@dev:alpha

workflows:
  notify_example:
    jobs:
      - notification/notify:
          slack_channel: "#devops"
          message: "Deployment completed successfully! 🚀"
          status: "success"
```

### Individual Commands

#### Slack Notification

```yaml
- notification/slack:
    channel: "#general"
    message: "Build completed!"
    status: "success"
    webhook_url: $SLACK_WEBHOOK_URL
```

#### Discord Notification

```yaml
- notification/discord:
    webhook_url: $DISCORD_WEBHOOK_URL
    message: "Build completed!"
    status: "success"
    username: "CircleCI Bot"
```

#### Teams Notification

```yaml
- notification/teams:
    webhook_url: $TEAMS_WEBHOOK_URL
    message: "Build completed!"
    status: "success"
    title: "CircleCI Build Notification"
```

#### Custom Webhook

```yaml
- notification/webhook:
    webhook_url: $CUSTOM_WEBHOOK_URL
    message: "Build completed!"
    status: "success"
    custom_payload: |
      {
        "custom_field": "custom_value",
        "status": "success"
      }
```

## Parameters

### Common Parameters

- `message`: Message to send (default: "Build completed!")
- `status`: Build status - success, failure, warning (default: "success")
- `webhook_url`: Webhook URL for the service

### Slack-specific

- `channel`: Slack channel (default: "#general")

### Discord-specific

- `username`: Bot username (default: "CircleCI Bot")

### Teams-specific

- `title`: Notification title (default: "CircleCI Build Notification")

### Webhook-specific

- `custom_payload`: Custom JSON payload (overrides default)

## Environment Variables

Set these in your CircleCI project settings:

- `SLACK_WEBHOOK_URL`: Your Slack webhook URL
- `DISCORD_WEBHOOK_URL`: Your Discord webhook URL
- `TEAMS_WEBHOOK_URL`: Your Teams webhook URL
- `CUSTOM_WEBHOOK_URL`: Your custom webhook URL

## Examples

### Complete Workflow

```yaml
version: 2.1

orbs:
  notification: unmars/slack-orb-demo@dev:alpha

workflows:
  ci_cd_pipeline:
    jobs:
      - build
      - test
      - deploy:
          requires: [build, test]
      - notification/notify:
          slack_channel: "#deployments"
          message: "Deployment to production completed! 🚀"
          status: "success"
          requires: [deploy]
          filters:
            branches:
              only: main
```

### Conditional Notifications

```yaml
- notification/notify:
    slack_channel: "#alerts"
    message: "Build failed on branch $CIRCLE_BRANCH"
    status: "failure"
    when: on_fail
```

## Development

This orb is built using the CircleCI CLI and follows the standard orb structure:

- `src/commands/`: Individual notification commands
- `src/jobs/`: Combined notification jobs
- `src/executors/`: Execution environments
- `src/examples/`: Usage examples

## License

MIT License - see LICENSE file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Support

For issues and questions, please open an issue on GitHub.
