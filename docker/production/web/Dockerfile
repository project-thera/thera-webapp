ARG RUBY_VERSION=2.7.4

FROM ruby:${RUBY_VERSION}-alpine AS builder

ENV BUNDLER_VERSION=2.2.16 \
    NODE_ENV=production \
    RAILS_APP=/usr/local/app \
    RAILS_ENV=production \
    RACK_ENV=production \
    SECRET_KEY_BASE=a-fake-secret-key

WORKDIR ${RAILS_APP}

ADD . $RAILS_APP

ARG NODE_VERSION=14.19.0-r0

RUN apk update -qq && \
    apk add -q --no-cache \
      build-base \
      git \
      nodejs~=${NODE_VERSION} \
      mariadb-dev \
      shared-mime-info \
      tzdata \
      yarn && \
    # https://bundler.io/man/bundle-config.1.html
    gem install bundler -v ${BUNDLER_VERSION} && \
    bundle config set cache_all 1 && \
    bundle config set deployment 1 && \
    bundle config set jobs 8 && \
    bundle config set retry 5 && \
    bundle config set without development:test:ubuntu && \
    bundle install && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete && \
    # https://classic.yarnpkg.com/en/docs/cli/install/
    yarn install --frozen-lockfile --non-interactive --production && \
    bundle exec rake assets:precompile && \
    yarn cache clean && \
    rm -rf node_modules tmp/cache vendor/assets test

FROM ruby:${RUBY_VERSION}-alpine
ENV RAILS_APP=/usr/local/app \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    TZ=America/Buenos_Aires

WORKDIR ${RAILS_APP}

COPY --from=builder /usr/lib /usr/lib
# COPY --from=builder /usr/share/fonts /usr/share/fonts
COPY --from=builder /usr/share/mime /usr/share/mime
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder ${RAILS_APP} ${RAILS_APP}

# COPY --from=builder $RAILS_APP/app $RAILS_APP/app
# COPY --from=builder $RAILS_APP/bin $RAILS_APP/bin
# COPY --from=builder $RAILS_APP/config $RAILS_APP/config
# COPY --from=builder $RAILS_APP/db $RAILS_APP/db
# COPY --from=builder $RAILS_APP/lib $RAILS_APP/lib
# COPY --from=builder $RAILS_APP/public $RAILS_APP/public
# COPY --from=builder $RAILS_APP/storage $RAILS_APP/storage
# COPY --from=builder $RAILS_APP/vendor $RAILS_APP/vendor
# COPY --from=builder $RAILS_APP/Gemfile $RAILS_APP/Gemfile.lock $RAILS_APP/config.ru $RAILS_APP/Rakefile $RAILS_APP/
# COPY --from=builder /usr/local/bundle /usr/local/bundle

EXPOSE 3000

# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
# CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
CMD [ "sh", "-c", "bundle exec rails server -b 0.0.0.0" ]

