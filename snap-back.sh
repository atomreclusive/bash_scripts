#!/bin/sh
if [ -d /var/roothome/BACKUP/.snapshots ]; then
	btrfs subvolume snapshot -r /var/roothome/BACKUP /var/roothome/BACKUP/.snapshots/safe-$(date +%Y%m%d)
	rsync -a /var/roothome/OG/Safe /var/roothome/BACKUP/
	SNAPDIR=/var/roothome/BACKUP/.snapshots
	OLDFOLDER=$(find $SNAPDIR -maxdepth 1 -type d -printf '%A@ %p\n' | sort | awk '{ print $2 }' | head -n 1)
	echo $OLDFOLDER
	btrfs subvolume delete $OLDFOLDER
else
	echo "Snapshots directory is not mounted."
	echo "Please unlock and mount the external drive."
fi
