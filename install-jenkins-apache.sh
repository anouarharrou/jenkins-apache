#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <yourdomain.com>"
    exit 1
fi

DOMAIN=$1

source ./scripts/functions.sh > /dev/null 2>&1 || source functions.sh > /dev/null 2>&1

########## JENKINS APACHE 2 DEPLOYMENT ##########

echo ""
echo -e '\E[1m'"\033[1mJENKINS INSTALLATION ALONG WITH APACHE2 WEB SERVER\033[0m"
echo -e '\E[1m'"\033[1mAUTHOR: ANOUAR HARROU\033[0m"
echo ""
echo -e '\E[1m'"\033[1mBy running this script, the following steps will be performed:\033[0m"
echo ""
echo -e '\E[1m'"\033[1m- Jenkins installation and configuration.\033[0m"
echo -e '\E[1m'"\033[1m- Apache2 web server setup as a reverse proxy for Jenkins.\033[0m"
echo -e '\E[1m'"\033[1m- Self-signed SSL certificate generation for secure communication.\033[0m"
echo ""

GetConfirmation

 # Detect Linux Distribution
 DIST=$(awk -F= '/^PRETTY_NAME/{print $2}' /etc/os-release)
 if [[ $DIST == *"Ubuntu"* ]]; then
     InstallOnUbuntu
elif [[ $DIST == *"CentOS Linux 7"* ]]; then
     InstallOnCentOS
 else
    echo "This installation script supports Ubuntu Server or CentOS 7..."
     exit 1
fi