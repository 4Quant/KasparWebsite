## Requirements

For project to succesfully run, you need to have already on your machine:

- Git
- Ruby
- Bundler
- node.js

If you don't have this installed, recomended way is using Homebrew.

## Setup process

Clone the repository using git, then run:

```
$ bundle install
```

## Development

```
$ bundle exec middleman
```

### Building

```
$ bundle exec middleman build
```

### Deployment

Deployment is done automaticly to GitHub pages every time you push changes to `master` branch.

#### Certificates

For https we are using Let's Encrypt service, which needs to be updated every few months.

Run this command and follow instructions:
```
sudo certbot certonly -a manual -d aifirst.ch -d www.aifirst.ch -d ai-first.ch -d www.ai-first.ch
```

When certificates are succesfully created, you need to add them on a github page here:
https://gitlab.com/4quant/ai-first-website/pages

## Testing

Go to https://4quant.gitlab.io/4quant.com/ after commit/merge