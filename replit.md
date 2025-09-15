# Goji Labs Interview Take-Home Project

## Overview
This is a Ruby on Rails 8.0 API-only application for a university course scheduling system. The project was successfully imported and configured to run in the Replit environment.

## Recent Changes
- **Date**: September 15, 2025
- Installed Ruby 3.3.8 with required system dependencies (libyaml, gcc, bundler, etc.)
- Configured PostgreSQL database connection using environment variables (DATABASE_URL, PGHOST, etc.)
- Set up Puma server to run on port 5000 with 0.0.0.0 binding for Replit proxy compatibility
- Modified development environment to allow all hosts for Replit's iframe preview
- Created Rails Server workflow for continuous development
- Fixed API-only configuration: root endpoint now returns JSON, properly configured as API-only
- Updated database configuration to use Replit PostgreSQL environment variables
- Configured deployment settings for autoscale production deployment

## Project Architecture
- **Framework**: Ruby on Rails 8.0.2.1
- **Ruby Version**: 3.3.8
- **Database**: PostgreSQL (configured via environment variables)
- **Server**: Puma web server
- **Architecture**: API-only application (config.api_only = true)
- **Testing**: RSpec testing framework
- **Linting**: RuboCop with Rails Omakase configuration

## Key Features & Models
According to the README, this system should include:
- Teachers, Students, Subjects, Classrooms models
- Sections model (join model connecting all entities with specific times)
- Schedule management with conflict detection
- PDF schedule generation capability

## Development Setup
The application is ready to run with:
- Database: Configured and connected to PostgreSQL
- Server: Running on port 5000 via Rails Server workflow
- Health endpoint: Available at `/up` (returns 200 OK)

## Database Configuration
- Development database: Uses environment variables (DATABASE_URL, PGHOST, PGUSER, etc.)
- Configuration supports both environment variable-based connection and explicit settings
- Schema and migrations ready for model development
- Health endpoint available at `/up` returns 200 OK
- Root endpoint at `/` returns JSON: `{"message":"API is running","status":"ok"}`

## Deployment
- Configured for autoscale deployment using `bundle exec rails server`
- Optimized for stateless API operations
- Production-ready configuration

## Next Steps
The foundation is complete and ready for:
1. Model generation (Teachers, Students, Subjects, Classrooms, Sections)
2. API endpoint development
3. Business logic implementation for schedule conflict detection
4. PDF generation functionality
5. Testing implementation

## User Preferences
- Standard Rails conventions and configurations maintained
- API-only architecture as per project requirements
- Clean, maintainable code structure following Rails best practices