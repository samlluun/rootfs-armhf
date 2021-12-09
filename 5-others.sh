#!/bin/bash
cp default rootfs/etc/nginx/sites-available/default
cp wiki/index.html rootfs/var/www/html/index.html
cp wiki/kms.html rootfs/var/www/html/kms.html
cp wiki/teasiu-wx.jpg rootfs/var/www/html/teasiu-wx.jpg
tar -zxvf h5ai.tar.gz -C rootfs/var/www/html/files/
cat <<EOT >> rootfs/etc/fstab
/dev/mmcblk0p6 / ext4 defaults,noatime,errors=remount-ro 0 1
EOT
cat <<EOT > rootfs/var/www/html/files/info.php
<?php
phpinfo();
?>
EOT
cat <<EOT > rootfs/etc/systemd/system/ttyd.service
[Unit]
Description=TTYD
After=syslog.target
After=network.target

[Service]
ExecStart=/usr/bin/ttyd login
Type=simple
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOT

cat <<EOT > rootfs/etc/systemd/system/vlmcsd.service
[Unit]
Description=vlmcsd
After=syslog.target
After=network.target

[Service]
ExecStart=/usr/bin/vlmcsd
Type=simple
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOT

cp ttyd.armhf rootfs/usr/bin/ttyd
cp vlmcsd rootfs/usr/bin/vlmcsd
chmod +x rootfs/usr/bin/ttyd
chmod +x rootfs/usr/bin/vlmcsd
chmod 644 rootfs/etc/systemd/system/ttyd.service
chmod 644 rootfs/etc/systemd/system/vlmcsd.service
cat <<EOT > rootfs/etc/network/interfaces.d/eth0
auto eth0
iface eth0 inet dhcp
EOT
echo "now ,dont forget chroot and adduser ubuntu & passwd root"
echo "change sudorios vi /etc/sudoreis"
