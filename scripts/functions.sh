#!/bin/bash

function GetConfirmation() {
    while true
    do
    echo -e '\E[96m'"\033\ Do you want to continue (Yes or No): \033[0m \c"
    read  CONFIRMATION
    case $CONFIRMATION in
    Yes|yes|YES|YeS|yeS|yEs) break ;;
    No|no|NO|nO)
    echo "Exiting..."
    sleep 1
    exit
    ;;
    *) echo "" && echo -e '\E[91m'"\033\Please type Yes or No \033[0m"
    esac
    done
    echo "Continue..."
    sleep 1
}

function InstallOnUbuntu() {
    # Step 1: Update the System
    sudo apt-get update -y && sudo apt-get upgrade -y

    # Step 2: Install Apache Web Server
    sudo apt install apache2 -y
    sudo systemctl enable apache2 && sudo systemctl start apache2

    # Step 3: Install Java
    sudo apt install openjdk-11-jdk -y
    java --version

    # Step 4: Install Jenkins
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update -y
    sudo apt install jenkins -y
    sudo systemctl start jenkins && sudo systemctl enable jenkins


    # Display status and allow user to skip with Ctrl+C
    echo "Checking Apache status..."
    echo "Press Ctrl+C to skip and continue with the installation."
    sleep 5  # Give a few seconds to press Ctrl+C
    sudo systemctl status apache2 || true  # "|| true" ignores the exit status of the status command


    # Prompt user for passphrase
    read -s -p "Enter passphrase for SSL certificate: " PASSPHRASE
    echo

    # Prompt user for certificate details
    read -p "Country Name (2 letter code) [AU]: " COUNTRY
    read -p "State or Province Name (full name) [Some-State]: " STATE
    read -p "Locality Name (eg, city) []: " CITY
    read -p "Organization Name (eg, company) [Internet Widgits Pty Ltd]: " ORG
    read -p "Organizational Unit Name (eg, section) []: " ORG_UNIT
    read -p "Common Name (e.g. server FQDN or YOUR name) []: " DOMAIN
    read -p "Email Address []: " EMAIL

    # Generate the Self-Signed SSL Certificate
    openssl req -x509 -newkey rsa:4096 -keyout jenkins.key -out jenkins.crt -days 365 -passin pass:"$PASSPHRASE" \
        -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$ORG_UNIT/CN=$DOMAIN/emailAddress=$EMAIL"

    echo "Self-Signed SSL Certificate generated successfully."
    sleep 5  # Give a few seconds to read the message

    #Copy the Certificate and Key to the /etc/ssl directory
    sudo cp jenkins.crt /etc/ssl/certs/
    sudo cp jenkins.key /etc/ssl/private/
    echo "Certificate and Key copied to /etc/ssl directory successfully."


    # Specify your server's fully qualified domain name
    FQDN="$DOMAIN"

    # Update the Apache global configuration file with ServerName
    echo "ServerName $FQDN" | sudo tee -a /etc/apache2/apache2.conf  # For Ubuntu/Debian


    # Step 5: Setting up Apache as a Reverse Proxy
    sudo bash -c "cat <<EOF > /etc/apache2/sites-available/jenkins.conf
    <VirtualHost *:80>
        ServerName $DOMAIN
        Redirect permanent / https://$DOMAIN/
    </VirtualHost>

    <VirtualHost *:443>
        ServerName $DOMAIN

        SSLEngine on
        SSLCertificateFile /etc/ssl/certs/jenkins.crt
        SSLCertificateKeyFile /etc/ssl/private/jenkins.key

        ProxyRequests Off
        ProxyPreserveHost On
        AllowEncodedSlashes NoDecode

        <Proxy http://localhost:8080/*>
            Order deny,allow
            Allow from all
        </Proxy>

        ProxyPass / http://localhost:8080/ nocanon
        ProxyPassReverse / http://localhost:8080/
        ProxyPassReverse / https://$DOMAIN/
    </VirtualHost>
    EOF"

    echo "Apache configured successfully."
    sleep 3  # Give a few seconds to read the message

    # Configure Jenkins etc/default/jenkins
    sudo sed -i "s#HTTP_PORT=8080#HTTP_PORT=8080\nHTTPS_KEYSTORE=\"/etc/ssl/certs/jenkins.crt\"\nHTTPS_KEYSTORE_PASSWORD=\"$PASSPHRASE\"#" /etc/default/jenkins

    echo "Jenkins configured successfully."
    sleep 3 # Give a few seconds to read the message

    # Restart Jenkins and Apache
    sudo a2ensite jenkins
    sudo a2enmod proxy
    sudo a2enmod proxy_http
    sudo a2enmod headers
    sudo a2enmod ssl
    sudo systemctl restart apache2

    # Prompt user for confirmation to install Ansible
    read -p "Do you want to proceed with Ansible installation? (y/n): " ANSWER
    if [ "$ANSWER" != "y" ]; then
        echo "Ansible installation skipped."
        exit 0
    fi

    # Step 6: Access Jenkins
    echo "Installation completed. Access Jenkins at https://www.$DOMAIN/"
    sleep 5  # Give a few seconds to read the message

    #  Install Ansible
    # Step 1: Update the system
    sudo apt update -y
    sudo apt upgrade -y

    # Step 2: Install Software Properties Common
    sudo apt-get install software-properties-common -y

    # Step 3: Add Ansible PPA
    sudo apt-add-repository --yes --update ppa:ansible/ansible

    # Step 4: Install Ansible
    sudo apt-get install ansible -y

    # Step 5: Display Ansible Version
    ansible --version

    echo "Ansible has been installed successfully."
}

function InstallOnCentOS() {

    echo "CentOS 7 is not supported yet."
}