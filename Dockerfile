FROM corgibytes/ruby-1.9.3

LABEL maintainer="you@example.com"

# Fix broken/expired Debian Jessie apt sources and disable GPG validation
RUN sed -i 's|http://security.debian.org|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|http://http.debian.net|http://archive.debian.org|g' /etc/apt/sources.list && \
    find /etc/apt/sources.list.d -type f -exec sed -i 's|http://http.debian.net|http://archive.debian.org|g' {} \; && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99disable-valid-until && \
    echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99disable-valid-until && \
    echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99disable-valid-until

# Install system dependencies (with unauthenticated allowed)
RUN apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get install -y --allow-unauthenticated \
    nodejs \
    sqlite3 \
    libsqlite3-dev \
    libmysqlclient-dev \
    libpq-dev \
    tzdata \
    git \
    curl

# Install Bundler compatible with Rails 3
RUN gem install bundler -v '~> 1.17'

# Set application directory
WORKDIR /app

# Copy Gemfile first to leverage Docker layer caching
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose default Rails port
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

