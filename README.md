# Slack Notification Orb for CircleCI

A simple and reusable Slack notification orb for CircleCI. Provides easy-to-use commands and jobs for sending notifications to your team with customizable messages and build status using the official CircleCI Slack orb.

## Features

- 🎯 **Targeted notifications**: Send to specific people (@username), teams (@channel), or channels (#channel)
- 🎨 **Rich formatting**: Customizable messages with emojis and colors
- 📊 **Build context**: Automatic inclusion of project, branch, and build information
- 🔧 **Simple API**: Easy-to-use commands and jobs
- 📱 **Real-time**: Instant notifications for your team
- 💬 **Mentions**: Additional mentions for specific teams or people
- 🚀 **Official integration**: Uses the official CircleCI Slack orb

## Usage

### Basic Usage

```yaml
version: 2.1

orbs:
  notification: unmars/slack-orb-demo@dev:alpha

workflows:
  notify_example:
    jobs:
      - notification/notify_success:
          channel: "#devops"
          message: "Deployment completed successfully! 🚀"
          mention: "@devops-team"
```

### Available Commands

#### Success Notification

```yaml
- notification/notify_success:
    channel: "#general"
    message: "✅ Build completed successfully!"
    mention: "@devops-team"
```

#### Failure Notification

```yaml
- notification/notify_failure:
    channel: "#alerts"
    message: "❌ Build failed!"
    mention: "@here"
```

#### Custom Notification

```yaml
- notification/notify_custom:
    channel: "#general"
    message: "Custom notification"
    status: "info" # success, failure, warning, info
    mention: "@team"
```

### Available Jobs

#### Success Job

```yaml
- notification/notify_success:
    channel: "#devops"
    message: "✅ Deployment completed successfully!"
    mention: "@devops-team"
```

#### Failure Job

```yaml
- notification/notify_failure:
    channel: "#alerts"
    message: "❌ Build failed!"
    mention: "@here"
```

#### Custom Job

```yaml
- notification/notify_custom:
    channel: "#general"
    message: "Custom notification"
    status: "info"
    mention: "@team"
```

## Parameters

### Common Parameters

- `channel`: Slack channel to send message to (default: $SLACK_DEFAULT_CHANNEL)
- `message`: Message to send
- `mention`: Additional mentions (e.g., @devops-team @manager)

### Custom Notification Parameters

- `status`: Status type - success, failure, warning, info (default: "info")

## Environment Variables

Set these in your CircleCI project settings:

- `SLACK_ACCESS_TOKEN`: Your Slack bot access token (starts with `xoxb-`)
- `SLACK_DEFAULT_CHANNEL`: Default Slack channel ID (e.g., `C1234567890`)

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
      - notification/notify_success:
          channel: "#deployments"
          message: "Deployment to production completed! 🚀"
          mention: "@devops-team"
          requires: [deploy]
          filters:
            branches:
              only: main
```

### Conditional Notifications

```yaml
- notification/notify_failure:
    channel: "#alerts"
    message: "Build failed on branch $CIRCLE_BRANCH"
    mention: "@here"
    when: on_fail
```

### Using Commands in Jobs

```yaml
jobs:
  build_and_notify:
    docker:
      - image: cimg/base:current
    steps:
      - checkout
      - run: echo "Building..."
      - notification/notify_success:
          channel: "#builds"
          message: "Build completed successfully!"
```

## Development

This orb is built using the CircleCI CLI and follows the standard orb structure:

- `src/@orb.yml`: Main orb definition
- `src/examples/`: Usage examples
- `test-config.yml`: Test configuration

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
