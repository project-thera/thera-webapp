ARG RUBY_VERSION=2.7.4

FROM ruby:${RUBY_VERSION}-alpine

ARG NODE_VERSION=14
ARG RAILS_VERSION=6.0.0
ARG USR=appuser
ARG GRP=appgroup
ARG UID=1000
ARG GID=1000
ARG RAILS_APP=/usr/local/app

# RUN apk update -qq 
# RUN apk add -q build-base nodejs tzdata yarn python
RUN apk update && apk add --no-cache \
  build-base \
  git \
  mariadb-dev \
  nodejs~=${NODE_VERSION} \
  shared-mime-info \
  sudo \
  tzdata \
  yarn

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
# COPY .railsrc /home/${USR}

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN gem install rails -v "~> ${RAILS_VERSION}"

# dev tools
RUN gem install ruby-debug-ide debase solargraph

WORKDIR ${RAILS_APP}

CMD ["sh", "-c", "./docker/development/web/start.sh"]