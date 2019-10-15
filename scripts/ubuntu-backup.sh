# backup root directory
date=`date +"%m%d%Y-%H%M%S"`
cd /
tar -cvpzf backup-${date}.tar.gz \
--exclude=/backup-*-*.tar.gz \
--exclude=/backup-*-*.tar.gz.gpg \
--exclude=/proc \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/dev \
--exclude=/sys \
--exclude=/run \
--exclude=/media \
--exclude=/var/log \
--exclude=/var/cache/apt/archives \
--exclude=/usr/src/linux-headers* \
--exclude=/home/*/.gvfs \
--exclude=/home/*/.cache \
--exclude=/home/*/.local/share/Trash \
/

