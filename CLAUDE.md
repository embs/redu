# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Redu is a social educational platform (Rede Social Educacional) built with Ruby on Rails 3.2 and Ruby 1.9.3. It provides features for courses, lectures, user interactions, and educational content management.

## Build & Development Commands

```bash
# Install dependencies
bundle install --binstubs

# Database setup
bundle exec rake db:create
bundle exec rake db:schema:load
bundle exec rake bootstrap:all    # Insert mandatory seed data

# Start development server
bundle exec rails server

# Start search server (Solr)
bundle exec rake sunspot:solr:start
bundle exec rake sunspot:solr:reindex
```

## Testing

```bash
# Run all tests
bundle exec rspec

# Run single test file
bundle exec rspec spec/models/user_spec.rb

# Run specific test
bundle exec rspec spec/models/user_spec.rb:42
```

Uses RSpec with FactoryGirl for fixtures. Test helpers are in `spec/support/`.

## Dependencies

- **MySQL 5.1** - Primary database
- **MongoDB 2.0.6** - Used for DelayedJob and other features
- **Solr 1.4.0** - Search engine (via Sunspot)

## Architecture

### Core Domain Models

The platform is built around an educational hierarchy:
- **Environment** → **Course** → **Space** → **Subject** → **Lecture**
- **User** has associations through `UserCourseAssociation`, `UserEnvironmentAssociation`

### Key Directories

- `app/observers/` - ActiveRecord observers including cache observers and Solr indexers
- `app/doorkeepers/` - Define events propagated on the message bus (Untied)
- `app/representers/` - API response representations (Roar)
- `app/services/` - Service objects
- `app/abilites/` - CanCan authorization abilities

### Background Jobs

Uses DelayedJob with MongoDB. Four worker queues:
- `general` - General async tasks
- `email` - Email delivery via Amazon SES
- `vis` - Visualization service HTTP requests
- `hierarchy-associations` - Priority hierarchy association creation

### External Services

- **Amazon S3** - File storage (Paperclip)
- **Amazon SES** - Email delivery
- **Zencoder** - Video transcoding
- **Pusher** - Real-time notifications
- **EngineYard** - Production deployment

### API

REST API with OAuth authentication. API-specific gems: `oauth-plugin`, `rack-cors`, `roar-rails`.

## Configuration Files

- `config/s3.yml` - S3 credentials
- `config/application.yml` - Extra application config
- `config/mimetypes.yml` - MIME type mappings

## Locale

Default locale is `pt-BR`. Translations are in `lang/ui/`.
