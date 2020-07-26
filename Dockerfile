ARG RAILS_ROOT=/app
ARG PACKAGES="build-base ruby-dev postgresql-dev xz-libs tzdata nodejs"

################################################################################
# Base configuration
#
FROM ruby:2.6-alpine AS builder-base
ARG RAILS_ROOT

WORKDIR $RAILS_ROOT
COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

################################################################################
# Production builder stage
#
FROM builder-base AS production-builder
ARG PACKAGES
RUN apk add --update-cache $PACKAGES && \
    bundle install --jobs 4 --retry 3 --deployment

################################################################################
# Production image
#
# Same as the base for the base image
FROM ruby:2.6-alpine AS production
ENV RAILS_ENV=production
ARG RAILS_ROOT
# Coping the generated artifacts and scrapping all the libs and binaries not necesary for execution
COPY --from=production-builder $RAILS_ROOT $RAILS_ROOT

################################################################################
# Development image
#
FROM builder-base AS development
ENV RAILS_ENV=development

ARG PACKAGES
ARG RAILS_ROOT

ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
ENV BUNDLE_PATH=/bundler
ENV BUNDLE_BIN="$BUNDLE_PATH/bin"
ENV PATH="$RAILS_ROOT/bin:$BUNDLE_BIN:$PATH"

RUN apk add --update-cache $PACKAGES && \
    bundle install --jobs 4 --retry 3
