# Jenkins with Apche2 Setup Script


This repository provides a streamlined solution for setting up a robust DevOps environment on Ubuntu, leveraging Jenkins for continuous integration, Apache as a reverse proxy for a custom domain, and Ansible for automation. The setup includes the generation of a self-signed SSL certificate to ensure secure communication.

## Prerequisites

```typescript
1. CentOS/Ubuntu System:
Ensure that you have a CentOS/Ubuntu server or virtual machine available.

2. Root or Sudo Access:
You should have root or sudo access to the machine.

3. Internet Connection:
The installation script requires an active internet connection to download and install packages.

4. Firewall Configuration:
If a firewall is enabled, ensure that it allows traffic on ports 80 and 443 for Apache and any other required ports for Jenkins.
```

## Installation

1. Clone this repository:

```bash
git clone https://github.com/anouarharrou/jenkins-ansible-roles.git

cd jenkins-ansible-roles
```
Make it executable:

```bash
chmod +x install-jenkins-apache.sh
```

# Note: 

if you're on Windows machine and you're using WSL2 on the top of the host to run Ubuntu LTS
add the following to C:\Windows\System32\drivers\etc\hosts

```script
C:\Windows\System32\drivers\etc\hosts

.
..
IP addr yourdomain.com #IP addr is the ip of ubuntu use ip add show to get the ip addres
```


2. Run the setup script:

```bash
./install-jenkins-apache.sh yourdomain.com
```
    

###  Replace yourdomain.com with your actual domain.

Follow the prompts to configure Jenkins, generate SSL certificates, and set up Apache.

Optionally, you can choose to install Ansible during the setup.

### The Apache default page may be showing up because the default Apache configuration is still active. The default Apache virtual host may not have been disabled.

You can disable the default site using the following command:
```bash
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
```

## Removal

To remove Jenkins and Apache, run the removal script:

Make it executable:

```bash
chmod +x remove-jenkins-apache.sh
```

```bash
./remove-jenkins-apache.sh
```

This script will stop Jenkins and Apache, remove the packages, and clean up configuration files.

## License

This project is licensed under the [GNU GENERAL PUBLIC LICENSE](./LICENSE).


Feel free to customize and enhance the stack according to your needs! 🛠️💡
