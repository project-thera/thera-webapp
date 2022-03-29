ARG RUBY_VERSION="2.7.4"

FROM ruby:${RUBY_VERSION}-alpine AS builder

ARG NODE_VERSION="14"

ENV BUNDLER_VERSION="2.2.16" \
    NODE_ENV="production" \
    RAILS_APP="/usr/local/app" \
    RAILS_ENV="production" \
    RACK_ENV="production" \
    SECRET_KEY_BASE="production"

WORKDIR ${RAILS_APP}

ADD . ${RAILS_APP}

RUN apk update -qq && \
    apk add -q --no-cache \
      build-base \
      git \
      mariadb-dev \
      nodejs~=${NODE_VERSION} \
      python2 \
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
    bundle install --clean --development && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete && \
    # https://classic.yarnpkg.com/en/docs/cli/install/
    yarn install --frozen-lockfile --non-interactive --production && \
    bundle exec rake assets:precompile && \
    yarn cache clean && \
    rm -rf node_modules tmp/cache vendor/assets test

FROM ruby:${RUBY_VERSION}-alpine

ARG USR="appuser"
ARG GRP="appgroup"
ARG UID="1000"
ARG GID="1000"

ENV RAILS_APP="/usr/local/app" \
    RAILS_ENV="production" \
    RAILS_LOG_TO_STDOUT=1 \
    RAILS_SERVE_STATIC_FILES=1

RUN addgroup --gid "${GID}" -S "${GRP}"

# https://linux.die.net/man/8/adduser
# https://qastack.mx/programming/49955097/how-do-i-add-a-user-when-im-using-alpine-as-a-base-image
RUN adduser \
  --home "/home/${USR}" \
  --gecos "" \
  --shell "/bin/sh" \
  --ingroup "${GRP}" \
  --disabled-password \
  --uid "${UID}" \
  "${USR}"

# https://ostechnix.com/add-delete-and-grant-sudo-privileges-to-users-in-alpine-linux/
# https://www.codegrepper.com/code-examples/shell/alpine+docker+add+user+and+group
# https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user#adduser

RUN echo "${USR} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
RUN mkdir -p ${RAILS_APP} && chown "${USR}:${GRP}" ${RAILS_APP} -R

USER ${UID}:${GID}

WORKDIR ${RAILS_APP}

COPY --from=builder /usr/lib /usr/lib
# COPY --from=builder /usr/share/fonts /usr/share/fonts
COPY --from=builder /usr/share/mime /usr/share/mime
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /usr/local/bundle /usr/local/bundle

# COPY --from=builder ${RAILS_APP} ${RAILS_APP}

COPY --chown=${UID}:${GID} --from=builder ${RAILS_APP}/app ${RAILS_APP}/app
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/bin ${RAILS_APP}/bin
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/config ${RAILS_APP}/config
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/db ${RAILS_APP}/db
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/lib ${RAILS_APP}/lib
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/public ${RAILS_APP}/public
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/storage ${RAILS_APP}/storage
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/vendor ${RAILS_APP}/vendor
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/Gemfile ${RAILS_APP}/Gemfile.lock ${RAILS_APP}/config.ru ${RAILS_APP}/Rakefile ${RAILS_APP}/
COPY --chown=${USR}:${GID} --from=builder ${RAILS_APP}/docker/production/web/start.sh ${RAILS_APP}/

RUN mkdir -p ${RAILS_APP}/tmp/pids

EXPOSE 3000

CMD ["sh", "-c", "./start.sh"]