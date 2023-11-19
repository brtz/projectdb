# projectdb
![ruby](https://github.com/brtz/projectdb/actions/workflows/ruby.yml/badge.svg)
![crystal](https://github.com/brtz/projectdb/actions/workflows/crystal.yml/badge.svg)

## About

projectdb is a rather small Ruby on Rails application to manage projects and related resources.
The core concepts are:

- manage projects with unique identifiers
- manage project related resources like environments or secrets
- be accessible through an REST API
- deliver a commandline client to access the API (projectdbctl)
- encrypt data at rest and at the application layer (see https://guides.rubyonrails.org/active_record_encryption.html)
- be scalable (do not store files locally, use redis as session storage)
- use JWT with revocation as API auth mechanism
- provide app and cli as container images
- be configurable through environment variables only

## Images
We provide container images at:

- projectdb: https://hub.docker.com/r/brtz/projectdb.
- projectdbctl: https://hub.docker.com/r/brtz/projectdbctl

Please check the tags. Versioning is not done by doing semver, but in a rolling release style with the tag's datetime.

Please see [docker-compose.yml](./docker-compose.yml) for an example stack (includes postgres as db and redis as cache/session store, both required).

## Configuration

To run projectdb you need to fulfill the following requirements first:

- provide a postgres database
- provide a redis as cache and session store

The following options can/must be set through environment variables:

| Variable  | Default | Required | Description |
| --------- |:-------:|:----------:|--------------|
| RAILS_ENV | "development" | yes | Which environment to use (development, test, production)|
| SECRET_KEY_BASE | nil | yes | a string that is used as base for encryption|
| DATABASE_URL | nil | yes | url address to your postgres (e.g. postgres://user:password@localhost:5432|
| PROJECTDB_REDIS_URL | nil | yes | url address to your redis (e.g. redis://localhost:6379|
| DEVISE_JWT_SECRET_KEY | nil | yes | a string that is used for JWT signing |
| ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY | nil | yes | active record encryption primary key |
| ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY | nil | yes | active record encryption deterministic key |
| ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT | nil | yes | active record encryption key derivation salt |

See [Active Record Encryption](https://guides.rubyonrails.org/active_record_encryption.html) for details on the last three.

Once you started the app itself, you need to run database preparation:

```bash
bin/rails db:migrate
bin/rails db:seed
# bin/rails db:prepare should also work just fine
```

This will run any pending db migrations and seed the app with two things:

- An admin user called admin@projectdb (pw: narfzort)
- An Api User called api@projectdb (pw: changethis)

Please make sure to login to your projectdb instance as admin@projectdb and change the passwords for these two users asap (Api Users->Edit and Users->Edit).

## Permissions
The access control list is based on the current_role on the logged in user.

Users with role "admin" can:
- CRUD projects
  - except delete projects with child projects, returns 302
- CRUD environments
- CRUD secrets
- CRUD api users
- CRUD users
  - except delete their own user, returns 409

Users with role "user" can:
- CRUD projects
  - except delete projects with child projects, returns 302
- CRUD environments
- CRUD secrets
- List api users

Api Users automatically receive the role "admin".

## projectdbctl
We provide projectdbctl as a client to manage your projectdb instance from the console. Please see [README.md](./projectdbctl/README.md) for details.

# TODO
- update docs with screenshot and logo
- dashboard
- resource milestones
- gantt chart (project GET)
