#!/bin/bash

##### Constants
# username="guest"
server="tower"
local_mount_point_root="/Volumes"

#Create the mount point:
declare -a shares=("downloads" "flash" "media" "private")

for share in "${shares[@]}"
do
    # create local mount point
    local_mount_point="$local_mount_point_root/$share"
    # mount share
    echo "Un-mounting: smb://${server}/${share} from: $local_mount_point ..."
    sudo umount $local_mount_point
    echo "Un-mounting: smb://${server}/${share} from: $local_mount_point ...done"
done

