#!/bin/bash

NEXTCLOUD_CONTAINER_NAME="docker_env-app-1" #name of the container

for i in {0..29}
do
    USERNAME="user${i}" #names of the users's storage that will be cleared

    # clearing the storage of the user
    docker exec --user www-data $NEXTCLOUD_CONTAINER_NAME sh -c "rm -rf /var/www/html/data/$USERNAME/files/*"

    # scanning the user's storage to ensure the changes are reflected in the user's storage directory
    docker exec --user www-data $NEXTCLOUD_CONTAINER_NAME /var/www/html/occ files:scan --path="$USERNAME/files"

    echo "The $USERNAME's storage has been erased."
done

echo "All users storage has been successfully cleared."