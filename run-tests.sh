# Uses docker-compose to run tests on GitHub Actions

# Exit if a step fails
set -e

echo "============== DB SETUP"
docker compose run redu rake db:create db:schema:load RAILS_ENV=test

echo "============== RSPEC"
docker compose run -e RAILS_ENV=test redu rspec
