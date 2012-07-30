#
# updates system
#
sudo aptitude update
sudo aptitude upgrade -y

#
# Installing VBoxLinuxAdditions
#

sudo aptitude install -y virtualbox-ose-guest-utils
# sudo aptitude install -y php-codesniffer php5-sqlite php5-xdebug git-core
sudo aptitude install -y phpmyadmin php5-curl php5-gd php5-mcrypt php-apc mc subversion

sudo usermod -aG vboxsf www-data
sudo usermod -aG vboxsf dev
cd /media/sf_webserver
mkdir -p backups public_html logs sites
cd ~
ln -s /media/sf_webserver/backups
ln -s /media/sf_webserver/public_html
ln -s /media/sf_webserver/logs
ln -s /media/sf_webserver/sites

sudo cp -f ~/dev/dvps-setup/templates/httpd.conf /etc/apache2/
sudo cp -f ~/dev/dvps-setup/templates/dvps.dev /etc/apache2/sites-available/
sudo a2ensite dvps.dev

#
# enabling apache's modules
#
sudo a2enmod rewrite

sudo service apache2 restart

#
# mysql create user
#
# CREATE USER 'dev'@'%' IDENTIFIED BY '***';
# GRANT USAGE ON * . * TO 'dev'@'%' IDENTIFIED BY '***' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
# GRANT ALL PRIVILEGES ON `dev\_%` . * TO 'dev'@'%';
