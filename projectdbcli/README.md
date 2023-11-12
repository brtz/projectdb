podman build --no-cache --tag localhost/projectdbcli:latest . &&
podman run --rm -it -e "PROJECTDBCLI_API_URL=http://host.containers.internal:3000" -e "PROJECTDBCLI_SILENT=true" -v /tmp:/tmp --entrypoint ./projectdbcli localhost/projectdbcli:latest -h &&
podman run --rm -it -e "PROJECTDBCLI_API_URL=http://host.containers.internal:3000" -e "PROJECTDBCLI_API_USERNAME=api@projectdb" -e "PROJECTDBCLI_API_PASSWORD=changethis" -v /tmp:/tmp --entrypoint ./projectdbcli localhost/projectdbcli:latest -c auth -r users &&
podman run --rm -it -e "PROJECTDBCLI_API_URL=http://host.containers.internal:3000" -e "PROJECTDBCLI_SILENT=true" -v /tmp:/tmp --entrypoint ./projectdbcli localhost/projectdbcli:latest -c list -r projects &&
podman run --rm -it -e "PROJECTDBCLI_API_URL=http://host.containers.internal:3000" -e "PROJECTDBCLI_SILENT=true" -v /tmp:/tmp --entrypoint ./projectdbcli localhost/projectdbcli:latest -c find -r secrets -f name -s "naught*"
