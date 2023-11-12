# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG BUN_VERSION=1.0.11
FROM registry.docker.com/oven/bun:$BUN_VERSION-alpine

WORKDIR /home/bun/app/

# Copy application code
COPY package.json ./
COPY bun.lockb ./
COPY src ./

# Install depencenies
RUN bun add -d bun-types
RUN bun install

# Compile to app
RUN bun build --compile ./projectdbcli.ts --outfile=projectdbcli
