# https://medium.com/magnetis-backstage/how-to-cache-bundle-install-with-docker-7bed453a5800
# https://gist.github.com/zentetsukenz/5e330b801f983e3d39757686dcb41cc2

ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION AS base

ENV RAILS_APP /usr/local/app
RUN apk update -qq 
RUN apk add -q build-base tzdata mariadb-dev shared-mime-info git

ARG BUNDLER_VERSION
RUN gem update --system
RUN gem install bundler:$BUNDLER_VERSION

WORKDIR /tmp
COPY Gemfile Gemfile.lock /tmp/
RUN bundle install --jobs 4 --retry 3

WORKDIR $RAILS_APP
COPY . $RAILS_APP

# nodejs
FROM base AS nodejs

RUN apk add -q nodejs python2 yarn

ENV PYTHON /usr/bin/python2
RUN yarn install --no-lockfile --production
RUN bundle exec rake webpacker:compile RAILS_ENV=production

# production
FROM base AS production

# RUN rm -rf ./node_modules ./public/packs ./tmp /tmp/* \
#     && bundle exec rake tmp:create

# FIXME
# don't remove node_modules because of rpi4 io performance
RUN rm -rf ./public/packs ./tmp /tmp/* \
    && bundle exec rake tmp:create

COPY --from=nodejs "$RAILS_APP/public/packs" "$RAILS_APP/public/packs"

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]