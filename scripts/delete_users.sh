#!/bin/bash

NEXTCLOUD_CONTAINER_NAME="docker_env-app-1" #name of the container
NUM_USERS_TO_DELETE=30 #number of users to delete +1 (the fisrt 31 users will be deleted)

for i in {0..NUM_USERS_TO_DELETE}
do
    USERNAME="user${i}" #select the user to delete
    docker exec --user www-data $NEXTCLOUD_CONTAINER_NAME /var/www/html/occ user:delete "$USERNAME" #delete the user
    echo "User $USERNAME deleted"
done

echo "All the selected users have been deleted."