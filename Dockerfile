ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

# make sure your domain is accepted
RUN mkdir /root/.ssh/ && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan gitlab.com >> /root/.ssh/known_hosts

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev samba-common-bin nodejs yarn && \
    apt-get clean

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

ARG BUNDLER_VERSION
RUN gem update --system
RUN gem install bundler:$BUNDLER_VERSION

RUN echo 'gem: --no-document' >> ~/.gemrc
