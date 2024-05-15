#!/bin/bash

NEXTCLOUD_CONTAINER_NAME="docker_env-app-1" #name of the container
DEFAULT_PSW='testanelcloud' #default password for all users
USER_STORAGE_QUOTA="3G" #storage quota for each user
USER_GROUP="users" #group for the user

#create 30 users
for i in {0..29}
do
    USERNAME="user${i}" #names of the users that will be created

    #settings for each user: 
    # - password, container, group and username 
    docker exec -e OC_PASS="$DEFAULT_PSW" --user www-data $NEXTCLOUD_CONTAINER_NAME /var/www/html/occ user:add --password-from-env --group="$USER_GROUP" "$USERNAME"
    # - storage quota of available space
    docker exec --user www-data $NEXTCLOUD_CONTAINER_NAME /var/www/html/occ user:setting "$USERNAME" files quota "$USER_STORAGE_QUOTA"

    #print the created users
    echo "User $USERNAME created with a user quota of $USER_STORAGE_QUOTA, in the group $USER_GROUP"
done

echo "All the users have been created."


