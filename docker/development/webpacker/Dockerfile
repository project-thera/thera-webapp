FROM thera-webapp_web:latest

WORKDIR /usr/local/app

RUN bundle exec rails webpacker:clobber

EXPOSE 3035

CMD ["bin/webpack-dev-server", "--inline", "true"]