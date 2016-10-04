#! /bin/bash

echo "This is script for automatic install of all dependencies for the Raspberry: HOME TEMEPERATURE, HUMIDITY AND AIR QUALITY MONITORING SYSTEM"
echo "Author Peter Kuralt, inspired by Peter Dalmaris, author of core project: https://github.com/PeterDalmaris"


echo "Installing updates"

apt-get update

echo "Installing upgrades"

apt-get install -y upgrade

echo "Install git-core"

apt-get install -y git-core

echo "Setting the git user"

git config --global user.name "terapevt"
git config --global user.email "terapevt@gmail.com"

echo "Cloning git repository"

git clone https://github.com/PeterKuralt/lab_app

cd lab_app

echo "Cloning Adafruit library"

git clone https://github.com/adafruit/Adafruit_python_DHT.git

echo "Installing NGINX server"

apt-get install -y nginx

echo "Starting nginx server"

/etc/init.d/nginx start

echo "Installing SQLite3 database and creating the database file"

apt-get install -y sqlite3
touch lab_app.db
 
echo "Installing python developing tools"

apt-get install -y python-dev

echo "Installing python setup-tools"

apt-get install -y python-setuptools

echo "Installing python pip"

apt-get -y install python-pip

echo "Installing python virtualenvironment"

pip install virtualenv

echo "Upgrading python virtualenvironment"

pip install virtualenv --upgrade

echo "Creating active virtual environment"

virtualenv venv

echo "Starting virtual environment venv"

. venv/bin/activate

echo "Installing all the neccessary python packages"

pip install -r requirements.txt

echo "Installing Adafruit sensor reading library"

cd Adafruit_python_DHT
 
python setup.py install

cd ..

echo "Configuring nginx and uwsgi servers"
echo "Creating a simbolic link of nginx config file"

ln -s /var/www/lab_app/lab_app_nginx.conf /etc/nginx/conf.d/

echo "Configuring uwsgi log files"

mkdir /var/log/uwsgi

rm /etc/nginx/sites-enabled/default

echo "Restarting nginx"

/etc/init.d/nginx restart

echo "Clear screen"

clear

echo "Installing upstart and copying the conf file to proper folder"

apt-get install -y upstart

mv /var/www/lab_app/uwsgi.conf /etc/init/

echo "Creating vassals folder"

mkdir -p /etc/uwsgi/vassals

echo "Creating symbolic link"

ln -s /var/www/lab_app/lab_app_uwsgi.ini /etc/uwsgi/vassals/

echo "Listing all the installed python pacgaked"

pip freeze


