# https://medium.com/magnetis-backstage/how-to-cache-bundle-install-with-docker-7bed453a5800
# https://gist.github.com/zentetsukenz/5e330b801f983e3d39757686dcb41cc2
# https://thecocktail.engineering/dockeriza-rails-para-producci%C3%B3n-ac25fd778df9

ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION AS base
# RUN apk update -qq && apk add -q build-base git mariadb-dev nodejs python2 shared-mime-info tzdata yarn
RUN apk update -qq && apk add -q mariadb-dev tzdata

ARG BUNDLER_VERSION
RUN gem update --system
RUN gem install bundler:$BUNDLER_VERSION

ENV RAILS_APP /usr/local/app
WORKDIR $RAILS_APP

# RUN bundle config set --local path $RAILS_APP/vendor
# RUN bundle config set --local without 'development test'
# ENV BUNDLE_PATH $RAILS_APP/vendor
# ENV BUNDLE_WITHOUT 'development test'

FROM base as builder
RUN apk add -q build-base git nodejs python2 shared-mime-info yarn

ENV NODE_ENV production
ENV PYTHON /usr/bin/python2
ENV RAILS_ENV production

# https://bundler.io/man/bundle-config.1.html
# ENV BUNDLE_DEPLOYMENT true
# ENV BUNDLE_PATH $RAILS_APP/vendor
ENV BUNDLE_WITHOUT 'development test'
# RUN bundle config set --local without 'development test'

WORKDIR /tmp
COPY Gemfile Gemfile.lock /tmp/
RUN bundle install --jobs 4 --retry 3

WORKDIR $RAILS_APP
COPY package.json yarn.lock $RAILS_APP/
RUN yarn install --pure-lockfile --production

COPY . $RAILS_APP

RUN bundle exec rake webpacker:compile

FROM base AS production

ENV RAILS_APP /usr/local/app
WORKDIR $RAILS_APP

COPY --from=builder $RAILS_APP/app $RAILS_APP/app
COPY --from=builder $RAILS_APP/bin $RAILS_APP/bin
COPY --from=builder $RAILS_APP/config $RAILS_APP/config
COPY --from=builder $RAILS_APP/db $RAILS_APP/db
COPY --from=builder $RAILS_APP/lib $RAILS_APP/lib
COPY --from=builder $RAILS_APP/public $RAILS_APP/public
COPY --from=builder $RAILS_APP/storage $RAILS_APP/storage
COPY --from=builder $RAILS_APP/vendor $RAILS_APP/vendor
COPY --from=builder $RAILS_APP/Gemfile $RAILS_APP/Gemfile.lock $RAILS_APP/config.ru $RAILS_APP/Rakefile $RAILS_APP/
COPY --from=builder /usr/local/bundle /usr/local/bundle

EXPOSE 3000

# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
# CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
CMD [ "sh", "-c", "bundle exec rails server -b 0.0.0.0" ]