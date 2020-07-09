FROM ruby:2.3.8

ARG RAILS_ROOT=/app
ARG PACKAGES='curl gnupg nodejs postgresql-client'

# Update container and add dependencies
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash - && \
    curl https://cli-assets.heroku.com/install.sh | sh && \
    apt-get update -y -qq && apt-get upgrade -y -qq && apt-get -y install $PACKAGES -qq && \
    apt-get clean

WORKDIR $RAILS_ROOT

ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
ENV BUNDLE_PATH=/bundler
ENV BUNDLE_BIN="$BUNDLE_PATH/bin"
ENV PATH="/app/bin:$BUNDLE_BIN:$PATH"

EXPOSE 3000
