FROM ruby:2.1

LABEL maintainer="you@example.com"

# Fix expired Jessie APT sources (remove jessie-updates, use archive mirrors)
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list && \
    sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99disable-valid-until && \
    echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99disable-valid-until && \
    echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99disable-valid-until

# Install packages (ignore expired keys and unauthenticated packages)
RUN apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get install -y --allow-unauthenticated \
    nodejs \
    sqlite3 \
    libsqlite3-dev \
    libmysqlclient-dev \
    libpq-dev \
    tzdata \
    git \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Bundler compatible with Rails 3
RUN gem install bundler -v '~> 1.17'

# Set app directory
WORKDIR /app

# Copy Gemfile first to cache layers
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the app code
COPY . .

# Expose Rails default port
EXPOSE 3000

# Start Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

