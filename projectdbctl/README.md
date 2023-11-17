# Readme

## Examples
The following examples show you projectdbctl's basic usage.

### build & auth
shards build -v --production &&
PROJECTDBCTL_API_URL=http://localhost:3000 PROJECTDBCTL_API_USERNAME=api@projectdb PROJECTDBCTL_API_PASSWORD=changethis ./bin/projectdbctl user auth

### list projects
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list | jq

### list projects using filters
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list -f "id:*" -f "custom_id:1" | jq

### delete project using the first project found
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project delete --confirm=true --id=$(PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list | jq -r .[0].id) | jq

If you get an error with status code 303, this means you tried to delete a resource that has dependencies that need to be removed first.
