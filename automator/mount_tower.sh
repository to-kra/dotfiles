#!/bin/bash

##### Constants
username="guest"
server="tower"
local_mount_point_root=/Volumes

#Create the mount point:
declare -a shares=("downloads" "flash" "media" "private")

for share in "${shares[@]}"
do
    # create local mount point
    local_mount_point="$local_mount_point_root/$share"
    if [ ! -d $local_mount_point ]; then
        echo "Creating: $local_mount_point"
        sudo mkdir -p $local_mount_point
    fi
    
    # mount share
    echo "Mounting: smb://${server}/${share} to: $local_mount_point ..."
    sudo mount_smbfs -N //${username}@${server}/${share} $local_mount_point
    echo "Mounting: smb://${server}/${share} to: $local_mount_point ...done"
done

