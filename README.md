# Thera Webapp

## Environment Variables

### Application
| key | description | required? |
| --- | ----------- | --------- |
| **NODE_ENV** | Node environment. You should use *production*. | yes |
| **RAILS_ENV** | Rails environment. You should use *production*. | yes |
| **RAILS_LOG_TO_STDOUT** | #TODO | yes |
| **RAILS_SERVE_STATIC_FILES** | #TODO | yes |
| **TZ** | #TODO | yes |

### Database
| key | description | required? |
| --- | ----------- | --------- |
| MYSQL_DATABASE | #TODO | yes |
| MYSQL_HOST | #TODO | yes |
| MYSQL_USER | #TODO | yes |
| MYSQL_PASSWORD | #TODO | yes |
| MYSQL_ROOT_PASSWORD | #TODO | yes |

### Mailer
| key | description | required? |
| --- | ----------- | --------- |
| MAILER_PROTOCOL | #TODO | yes |
| MAILER_HOST | #TODO | yes |
| MAILER_USER_NAME | #TODO | yes |
| MAILER_PASSWORD | #TODO | yes |

| MAILER_PROTOCOL | #TODO | yes |
| MAILER_PROTOCOL | #TODO | yes |
| MAILER_PROTOCOL | #TODO | yes |
| MAILER_PROTOCOL | #TODO | yes |

## Development

To run the project copy file `docker/development/.env.example` to `docker/development/.env`

Then:
```
docker-compose build web
docker-compose run web bundle install -j4
docker-compose run web yarn install

docker-compose build webpacker

docker-compose restart

docker-compose exec web db:create
docker-compose exec web db:migrate
docker-compose exec web db:seed
```

You can access with user `matiasarrech@gmail.com` and password `dev`.