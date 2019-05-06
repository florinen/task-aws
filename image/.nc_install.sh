#!/bin/bash
# Follow the steps bellow to install and configure Nextcloud 15 on your CentOS 7 server. 
# It can be a freshly installed or a server with running applications provided you can satisfy pre-requisites and required dependencies
# PHP, we will use PHP 7.3 since it is the latest stable release of PHP available for CentOS 7. 
# This is available on Remi repository which needs to be added prior to installation.

# Add Remi repository
sudo yum -y install epel-release yum-utils
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Disable default PHP 5.x enabled repository and enable one for PHP 7.3
sudo yum-config-manager --disable remi-php54
sudo yum-config-manager --enable remi-php73

# Then install Apache and PHP packages
sudo yum -y install httpd php php-cli php-mysql mysql php-zip php-pecl-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-pdo php-pecl-apcu php-pecl-apcu-devel
sudo yum -y install wget unzip vim

# Download and Install Nextcloud
wget https://download.nextcloud.com/server/releases/latest-15.zip
unzip latest-15.zip
sudo rm -f latest-15.zip
sudo mv nextcloud/ /var/www/html/
sudo mkdir /var/www/html/nextcloud/data

# Give apache user and group the ownership of nextcloud folder
#sudo chown apache:apache -R /var/www/html/nextcloud/data
sudo chown apache:apache -R /var/www/html/nextcloud

# Configure Apache VirtualHost, configuration file for Nextcloud
sudo cat <<EOF >  /etc/httpd/conf.d/nextcloud.conf
<VirtualHost *:3000>
  ServerName nextcloud.devopnet.com
  DocumentRoot /var/www/html/nextcloud
  <directory /var/www/html/nextcloud>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews
    SetEnv HOME /var/www/html/nextcloud
    SetEnv HTTP_HOME /var/www/html/nextcloud
  </directory>
</VirtualHost>
EOF

# Change the Listening port to mach the one configure on your SG
sudo sed -i '0,/Listen [0-9]*/s//Listen 3000/' /etc/httpd/conf/httpd.conf
sudo sed -i "/^<Directory \"\/var\/www\/html\">/,/^<\/Directory>/{s/AllowOverride None/AllowOverride All/g}" /etc/httpd/conf/httpd.conf
sudo systemctl enable --now httpd

# Configure the firewall to allow access to the Nextcloud storage from external machines.
sudo yum -y install firewalld
sudo systemctl enable --now firewalld
sudo firewall-cmd --add-service={http,https} --permanent
sudo firewall-cmd --reload

# To add port 3000 to port contexts, enter:
sudo semanage port -a -t http_port_t -p tcp 3000

# To allow Apache to connect to remote database through SELinux
sudo setsebool httpd_can_network_connect_db 1

# Set SELinux context to allow NextCloud to write the data inside its important directories
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/nextcloud/data'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/nextcloud/config(/.*)?'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/nextcloud/apps(/.*)?'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/nextcloud/3rdparty(/.*)?'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/nextcloud/.htaccess'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/nextcloud/.user.ini'

sudo restorecon -Rv '/var/www/html/nextcloud/'