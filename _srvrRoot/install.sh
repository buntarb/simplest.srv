
########################################################################################################################
# See version and code name of Ubuntu Server.                                                                          #
########################################################################################################################

lsb_release -a #

sudo su
apt-get update
apt-get upgrade
apt-get install -y console-cyrillic
nano /etc/rc.local

########################################################################################################################
# Add 'cyr' to /etc/rc.local before 'exit 0'.                                                                          #
########################################################################################################################

sudo adduser zinychz
sudo adduser zinychz sudo
usermod -G www-data -a buntarb
usermod -G www-data -a zinychz
usermod -G buntarb -a zinychz
usermod -G zinychz -a buntarb
apt-get install ntp ntpdate
apt-get install mc
apt-get install ssh openssh-server
apt-get install proftpd
apt-get install nginx
apt-get install git-core gcc autoconf
apt-get install memcached

# MongoDB
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
apt-get update
apt-get install mongodb-10gen

# PerconaServer
gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
gpg -a --export CD2EFD2A | sudo apt-key add -

########################################################################################################################
# nano /etc/apt/sources.list                                                                                           #
# and add                                                                                                              #
# deb http://repo.percona.com/apt trusty main                                                                          #
# deb-src http://repo.percona.com/apt trusty main                                                                      #
# into end of file                                                                                                     #
########################################################################################################################

apt-get update
apt-get install percona-server-server-5.5 percona-server-client-5.5
apt-get install percona-toolkit

nano /etc/network/interfaces

########################################################################################################################
# Edit network configuration.                                                                                          #
########################################################################################################################

reboot

########################################################################################################################
# You can work by SSH from this place.                                                                                 #
########################################################################################################################

########################################################################################################################
# Block below required for VirtulBox guest additions.                                                                  #
########################################################################################################################

sudo su
sudo apt-get install build-essential
sudo apt-get install dkms
mount /dev/cdrom /media/cdrom
sh /media/cdrom/VBoxLinuxAdditions.run

########################################################################################################################
# Create and setup project dirs.                                                                                       #
########################################################################################################################

mkdir /home/www-data/
chown www-data /home/www-data/ -R

mkdir /var/cache/nginx/
chown www-data:www-data -R /var/cache/nginx/

mkdir /var/www/
mkdir /var/www/simplest.srv

mkdir /var/www/simplest.srv/_srvrRoot
mkdir /var/www/simplest.srv/_srvrRoot/tmp
mkdir /var/www/simplest.srv/_srvrRoot/etc
mkdir /var/www/simplest.srv/_srvrRoot/etc/apt
mkdir /var/www/simplest.srv/_srvrRoot/etc/network
mkdir /var/www/simplest.srv/_srvrRoot/etc/nginx
mkdir /var/www/simplest.srv/_srvrRoot/etc/nginx/sites-available
mkdir /var/www/simplest.srv/_srvrRoot/home
mkdir /var/www/simplest.srv/_srvrRoot/var
mkdir /var/www/simplest.srv/_srvrRoot/var/log
mkdir /var/www/simplest.srv/_srvrRoot/var/log/nginx
mkdir /var/www/simplest.srv/_srvrRoot/var/log/mongodb
mkdir /var/www/simplest.srv/_srvrRoot/var/log/mysql
mkdir /var/www/simplest.srv/_srvrRoot/download
mkdir /var/www/simplest.srv/_tomcat

chmod -R a-rwx,u+rwX,g+rwX /var/www && chown www-data:www-data -R /var/www

rm -f /etc/nginx/nginx.conf
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-available/videtype.conf
rm -rf /etc/nginx/sites-enabled

########################################################################################################################
# Upgrading /etc/nginx/ with config files links.                                                                       #
########################################################################################################################

ln -s /var/www/simplest.srv/_srvrRoot/etc/nginx/sites-available/madmap.conf /etc/nginx/sites-available/madmap.conf
ln -s /var/www/simplest.srv/_srvrRoot/etc/nginx/nginx.conf /etc/nginx/nginx.conf

########################################################################################################################
# Upgrading _srvrRoot with data access links.                                                                          #
########################################################################################################################

ln /var/log/nginx/access.log /var/www/simplest.srv/_srvrRoot/var/log/nginx/access.log
ln /var/log/nginx/error.log /var/www/simplest.srv/_srvrRoot/var/log/nginx/error.log
ln /var/log/nginx/madmap.log /var/www/simplest.srv/_srvrRoot/var/log/nginx/madmap.log
ln /var/log/nginx/madmap.err /var/www/simplest.srv/_srvrRoot/var/log/nginx/madmap.err
ln /var/log/mongodb/mongodb.log /var/www/simplest.srv/_srvrRoot/var/log/mongodb/mongodb.log
ln /var/log/mysql/error.log /var/www/simplest.srv/_srvrRoot/var/log/mysql/error.log
ln /var/log/memcached.log /var/www/simplest.srv/_srvrRoot/var/log/memcached.log

########################################################################################################################
# For production mode without ftp access we need to change permissions:                                                #
#                                                                                                                      #
# chmod -R a-rwx,u+rwX,g+rX /var/www && chown www-data:www-data -R /var/www                                            #
########################################################################################################################

########################################################################################################################
# Install Node.js version manager.                                                                                     #
########################################################################################################################

apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev

########################################################################################################################
# Exit super user mode and activate nvm.                                                                               #
########################################################################################################################

exit
git clone git://github.com/creationix/nvm.git ~/nvm
echo '. ~/nvm/nvm.sh' >> ~/.bashrc && . ~/.bashrc

########################################################################################################################
# Install Node.js.                                                                                                     #
########################################################################################################################

nvm install 0.10.32
nvm use 0.10.32
nvm alias default 0.10.32
npm config set strict-ssl false

########################################################################################################################
# Open super user mode.                                                                                                #
########################################################################################################################

sudo apt-get install nodejs-legacy

########################################################################################################################
# Install node packages.                                                                                               #
########################################################################################################################

npm install -g express
npm install -g q
npm install -g async
npm install -g mc
npm install -g mongodb
npm install -g body-parser
npm install -g compression
npm install -g connect-timeout
npm install -g cookie-parser
npm install -g cookie-session
npm install -g csurf
npm install -g errorhandler
npm install -g method-override
npm install -g response-time
npm install -g serve-favicon
npm install -g serve-index
npm install -g serve-static
npm install -g vhost
npm install -g jsDAV

########################################################################################################################
# Install tomcat server.                                                                                               #
########################################################################################################################

apt-get install openjdk-7-jdk

# We need to download apache-tomcat-8.0.9.tar.gz file to _srvrRoot/download dir now. #

########################################################################################################################
# Important! Unpack this archive with user (not root) privileges.                                                      #
########################################################################################################################

tar -zxvf /var/www/simplest.srv/_srvrRoot/download/apache-tomcat-8.0.9.tar.gz -C /var/www/simplest.srv/_tomcat

########################################################################################################################
# Edit /var/www/simplest.srv/_tomcat/apache-tomcat-8.0.9/bin/setclasspath.sh - add first line:                           #
# JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386                                                                           #
#                                                                                                                      #
# Edit /var/www/simplest.srv/tomcat/apache-tomcat-8.0.9/conf/tomcat-users.xml. Add following lines above the last line:  #
# <role rolename="manager-gui"/>                                                                                       #
# <user username="tomcat" password="tomcat" roles="manager-gui"/>                                                      #
########################################################################################################################