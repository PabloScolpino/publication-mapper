FROM ruby:2.6

ARG RAILS_MAX_WORKERS=1
ARG RAILS_LOG_TO_STDOUT=true
ARG LOG_LEVEL=DEBUG
ARG PORT=3000
ARG DATABASE_URL=default

ARG FACEBOOK_APP_ID=default
ARG FACEBOOK_APP_SECRET=default

ARG GOOGLE_API_KEY=default

ARG CLOUDINARY_NAME=default
ARG CLOUDINARY_API_KEY=default
ARG CLOUDINARY_API_SECRET=default
ARG COVERALLS_REPO_TOKEN=default
ARG ROLLBAR_ACCESS_TOKEN=default

ARG RAILS_ROOT=/app
ARG PACKAGES='curl gnupg nodejs postgresql-client'

# Update container and add dependencies
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash - && \
    apt-get update -y -qq && apt-get upgrade -y -qq && apt-get -y install $PACKAGES -qq && \
    apt-get clean

WORKDIR $RAILS_ROOT

ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
ENV BUNDLE_PATH=/bundler
ENV BUNDLE_BIN="$BUNDLE_PATH/bin"
ENV PATH="/app/bin:$BUNDLE_BIN:$PATH"

ADD . .

RUN bundle install

EXPOSE 3000
CMD "bundle exec puma -C config/puma.rb"
