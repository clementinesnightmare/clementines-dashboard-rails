# Clementine's Nightmare Dashboard

## Local Development Setup
- `gem install bundler`
- `gem install rails`
- `bundle install`
- Set your `MORALIS_API_KEY` in a `.env` file (or specify it when running commands).
- `rake` to run all tests.
- `bundle exec rake rubocop` to see rubocop offenses.
- `rails db:reset db:migrate` will reset database and reload current schema.
- `rails db:drop db:create db:migrate` will destroy the database and recreate the schema. 
- `rails assets:precompile` to precompile assets.
- `rails s` to start the server. The site will be available at `localhost:3000`.
- `bundle exec rake docker:build` to build docker image for production.
- `docker-compose up` to run production image. The site will be available at `localhost:9001`.
- `bundle exec sidekiq` to start local Sidekiq server. The server will look for Redis at 127.0.0.1:6379. You can run a local instance of Redis or start up services in Docker (`docker-compose up`) which includes a Redis server listening on port `6379`.
- Sidekiq UI will be available at `localhost:3000/sidekiq` (make sure the rails server `rails s` is running).

## Database
- In development and test environments, we use sqlite3. In production, we use postgres.