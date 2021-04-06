# https://medium.com/magnetis-backstage/how-to-cache-bundle-install-with-docker-7bed453a5800

ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

RUN apk update -qq 
# RUN apk add -q build-base nodejs tzdata yarn python
RUN apk add -q build-base nodejs tzdata yarn mariadb-dev shared-mime-info git

ARG BUNDLER_VERSION
RUN gem update --system
RUN gem install bundler:$BUNDLER_VERSION

ENV RAILS_APP /usr/local/app
RUN mkdir -p $RAILS_APP

WORKDIR $RAILS_APP

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --jobs 4 --retry 3

COPY . $RAILS_APP

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]