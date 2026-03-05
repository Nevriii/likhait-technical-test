# syntax = docker/dockerfile:1

# Use Ruby 3.3.7
ARG RUBY_VERSION=3.3.7
FROM ruby:$RUBY_VERSION-slim

# Rails app lives here
WORKDIR /rails

# Install base packages (---fixed docker command---)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \ 
    ca-certificates \ 
    default-mysql-client \ 
    default-libmysqlclient-dev \ 
    git \
    libssl-dev \
    libyaml-dev \
    libreadline-dev \
    zlib1g-dev \
    nodejs \
    curl && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install application gems
COPY Gemfile Gemfile.lock ./

# Ensure Bundler version matches Gemfile.lock
RUN gem install bundler -v 2.6.8

# Configure bundler and install gems with retry logic
RUN bundle config set --local deployment 'false' && \
    bundle config set --local path '/usr/local/bundle' && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Securely copy and normalize entrypoint script to avoid volume shadowing
COPY bin/docker-entrypoint /usr/bin/
RUN sed -i 's/\r$//' /usr/bin/docker-entrypoint && \
    chmod +x /usr/bin/docker-entrypoint

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Entrypoint prepares the database
ENTRYPOINT ["/usr/bin/docker-entrypoint"]

# Start the server by default
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]