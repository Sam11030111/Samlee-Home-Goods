# syntax = docker/dockerfile:1

# Use a Ruby base image
ARG RUBY_VERSION=3.3.3
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install dependencies for building gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Expose port 3000 for Rails server
EXPOSE 3000

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Start Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]

