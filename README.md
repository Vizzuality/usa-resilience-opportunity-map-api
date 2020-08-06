# README

This is the api for the USA Resilience Map

* Ruby version: 2.7.1
* Rails version: 6.0.3.2

## Deploying

Configure the .env file with the `PRODUCTION_IP` and `SSH_USER` and run `cap production deploy`

## System dependencies

* Postgres 12 and Postgis 3

## Tasks
### Importers

- Geometries: `rails import:locations`
- Indicators: `rails import:indicators`
- Active Admin user: `rails db:seed`
