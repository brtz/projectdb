shards build -v --production && PROJECTDBCTL_API_URL=http://localhost:3000 PROJECTDBCTL_API_USERNAME=api@projectdb PROJECTDBCTL_API_PASSWORD=changethis ./bin/projectdbctl user auth
shards build -v --production && PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list
shards build -v --production && PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list -f "id:*" -f "custom_id:1"
shards build -v --production && PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl secret list | jq
