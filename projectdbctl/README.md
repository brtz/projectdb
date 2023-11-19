# Readme

## Image

## How to build
There are two ways available to build projectdbctl. Either locally using an installed crystal (1.10.1) or by having a container runtime build it to an image.

The command to build it locally:

```bash
shards build --verbose --production --release --static --no-debug
# results in a local bin/projectdbctl executable
```

To build it with a container runtime (e.g. docker):
```bash
docker build --tag local/projectdbctl:latest .
# results in an image called local/projectdbctl:latest that can be run like this
# docker run --rm -it local/projectdbctl
```

## Examples
The following examples show you projectdbctl's basic usage. These examples rely on jq to format the output and assume http://localhost:3000 to be your projectdb url.

### auth
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 PROJECTDBCTL_API_USERNAME=api@projectdb PROJECTDBCTL_API_PASSWORD=changethis ./bin/projectdbctl user auth
```

### list projects
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list | jq
```

### list projects using filters
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list -f "id:*" -f "custom_id:1" | jq
```

### delete project using the first project found
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project delete --confirm=true --id=$(PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list | jq -r .[0].id) | jq
```
If you get an error with status code 409, this means you tried to delete a resource that has dependencies that need to be removed first.

### get the spec for a resource (e.g. project)
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project spec | jq > /tmp/projectdb-spec-projects
```
This can be used as a template for resource creation.

### create a new project
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project create --file /tmp/projectdb-spec-projects
```
This will load the contents from the specified --file.
If you get an error with status code 409, this means your request is not according to spec. You most likely missed to specify a required
field (e.g. user_id on project).

### update an existing project
```bash
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project list | jq -r .[0] > /tmp/projectdb-example
# edit /tmp/projectdb-example with your favorite editor.
PROJECTDBCTL_API_URL=http://localhost:3000 ./bin/projectdbctl project update --files /tmp/projectdb-example --id $(cat /tmp/projectdb-example | jq -r .id)
```
First we save the first entry from the project list (e.g. the one you wish to edit) as /tmp/projectdb-example.
Then you need to update the file to your liking.
Lastly we update the resource with the contents from the specified --file using the id field from that file.
Same as on create, if you receive a 409 it's probably a required field that you missed.
