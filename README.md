# Thera Webapp

## Quick reference
* **Maintained by** [daniffig](https://github.com/daniffig/) and Matías Arrech
* **Where to get help?** You can [submit your ticket](https://github.com/project-thera/thera-webapp/issues) as an issue.
* **Live app** at [Proyecto: Thera App](https://app.proyectothera.com.ar)

## What is Proyecto: Thera?

## How to setup this application

### Requirements
* MySQL ~> v5.6.0 or MariaDB ~> v10.0
* an email account

### Docker Compose
The easiest way to get this app working is to setup its environment with Docker Compose. In the example provided below we use [linuxserver.io MariaDB image](https://hub.docker.com/r/linuxserver/mariadb) because it has better compatibility with our Raspberry Pi infraestructure.

```yaml
# docker-compose.yml

version: '3'

services:
  db:
    image: linuxserver/mariadb:10.5.15
    env_file: production.env
    volumes:
      - db_data:/config
    restart: unless-stopped

  web:
    image: ghcr.io/project-thera/thera-webapp
    env_file: production.env
    ports:
      - 3000:3000/tcp
    volumes:
      - web_log:/usr/local/app/log
      - web_uploads:/usr/local/app/private/web_uploads
    restart: unless-stopped
    depends_on:
      - db

volumes:
  db_data:
  web_log:
  web_uploads:
```

As you may observe we define three volumes: *db_data* to persist the data saved in our database instance, *web_log* to save the logs generate by the web app and *web_uploads* to persist the files uploaded to the web app.

We also make use of a *production.env* file that we share between our *db* and *web* containers. You *MUST* set the following env variables among others.

```
# production.env

MAILER_PROTOCOL=
MAILER_HOST=
MAILER_USER_NAME=
MAILER_PASSWORD=
MYSQL_ROOT_PASSWORD=
MYSQL_HOST=
MYSQL_DATABASE="thera-webapp"
MYSQL_USER="thera-webapp_user"
MYSQL_PASSWORD=
SECRET_KEY_BASE=
TZ="America/Argentina/Buenos_Aires"
```