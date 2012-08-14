#!/bin/bash

if [[ "`groups`" == *"vboxsf"* ]]; then
  echo "VirtualBox guest utils are installed already"
else
  echo "Upgrading the system"
  sudo aptitude update
  sudo aptitude upgrade -y

  echo "Installing VirtualBox guest utils"
  sudo aptitude install -y virtualbox-ose-guest-utils

  echo "Adding '$USER' and 'www-data' users to 'vboxsf' group"
  sudo usermod -aG vboxsf www-data
  sudo usermod -aG vboxsf $USER

  echo "You should restart the system and run this script again to complete setup"
  exit 0
fi

echo "Creating webserver directory structure"
cd /media/sf_webserver && mkdir -p backups public_html logs sites
cd ~
ln -s /media/sf_webserver/backups
ln -s /media/sf_webserver/public_html
ln -s /media/sf_webserver/logs
ln -s /media/sf_webserver/sites

echo "Configuring Apache"

sudo cp -f ~/dvps-setup/templates/httpd.conf /etc/apache2/
sudo cp -f ~/dvps-setup/templates/username.dvps /etc/apache2/sites-available/$USER.dvps
sudo sed -i "s/username/$USER/g" /etc/apache2/sites-available/$USER.dvps
sudo a2ensite $USER.dvps
echo "Do not forget to virtual domain to your hosts file:"
echo "127.0.0.1 $USER.dvps"
sudo a2enmod rewrite
sudo service apache2 restart

echo "Installing development software"
# sudo aptitude install -y php-codesniffer php5-sqlite php5-xdebug git-core
sudo aptitude install -y phpmyadmin php5-curl php5-gd php5-mcrypt php-apc mc subversion git-core

#
# mysql create user
#
# CREATE USER 'dev'@'%' IDENTIFIED BY '***';
# GRANT USAGE ON * . * TO 'dev'@'%' IDENTIFIED BY '***' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
# GRANT ALL PRIVILEGES ON `dev\_%` . * TO 'dev'@'%';
