# Use Ruby 2.6 (Debian Bullseye-based)
FROM ruby:2.6

LABEL maintainer="you@example.com"

# Install required system packages
RUN apt-get update && \
    apt-get install -y \
    nodejs \
    sqlite3 \
    libsqlite3-dev \
    libmariadb-dev \
    libpq-dev \
    tzdata \
    git \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Bundler compatible with Rails 3/4
RUN gem install bundler -v '~> 1.17'

# Set the working directory inside the container
WORKDIR /app

# Copy Gemfile and lockfile first for better Docker cache performance
COPY Gemfile Gemfile.lock ./

# Install gems via Bundler
RUN bundle install

# Copy the rest of the app source code
COPY . .

# Expose the default Rails server port
EXPOSE 3000

# Start the Rails server on container start
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

