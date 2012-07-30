echo "Updating the system..."
sudo aptitude update
sudo aptitude upgrade -y

echo "Installing VirtualBox guest utils..."
sudo aptitude install -y virtualbox-ose-guest-utils

echo "Adding 'dev' and 'www-data' users to 'vboxsf' group..."
sudo usermod -aG vboxsf www-data
sudo usermod -aG vboxsf dev

echo "Creating webserver directory structure..."
cd /media/sf_webserver
mkdir -p backups public_html logs sites
cd ~
ln -s /media/sf_webserver/backups
ln -s /media/sf_webserver/public_html
ln -s /media/sf_webserver/logs
ln -s /media/sf_webserver/sites

echo "Configuring Apache..."
sudo cp -f ~/dev/dvps-setup/templates/httpd.conf /etc/apache2/
sudo cp -f ~/dev/dvps-setup/templates/dvps.dev /etc/apache2/sites-available/
sudo a2ensite dvps.dev
sudo a2enmod rewrite

echo "Installing development software..."
# sudo aptitude install -y php-codesniffer php5-sqlite php5-xdebug git-core
sudo aptitude install -y phpmyadmin php5-curl php5-gd php5-mcrypt php-apc mc subversion git-core

echo "Restarting Apache..."
sudo service apache2 restart

#
# mysql create user
#
# CREATE USER 'dev'@'%' IDENTIFIED BY '***';
# GRANT USAGE ON * . * TO 'dev'@'%' IDENTIFIED BY '***' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
# GRANT ALL PRIVILEGES ON `dev\_%` . * TO 'dev'@'%';
