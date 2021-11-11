# Thera Webapp

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