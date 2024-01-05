#!/bin/bash
RPISERVER=$(cat rpi_server.txt)
NASSERVER=$(cat nas_server.txt)
DISKUUID=$(cat disk_uuid.txt)

read -sp "Encryption password: " PASSWORD
# publickey previously set up; no password to sign in
ssh root@$RPISERVER << EOF
mount -r -t nfs $NASSERVER:/mnt/Represent/Safe /var/roothome/OG/Safe
echo $PASSWORD | cryptsetup luksOpen /dev/disk/by-uuid/$DISKUUID discopanic
mount /dev/mapper/discopanic /var/roothome/BACKUP
EOF
