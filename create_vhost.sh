#!/bin/bash

# Function to create a virtual host file
create_virtual_host() {
    read -p "Enter the domain name (e.g., example.com): " domain
    read -p "Enter the document root path (e.g., /var/www/example.com): " docroot

    # Create document root directory if it doesn't exist
    if [ ! -d "$docroot" ]; then
        mkdir -p "$docroot"
        echo "Document root created at $docroot"
    fi

    # Create a virtual host configuration file
    vhost_conf="/etc/apache2/sites-available/$domain.conf"
    cat > "$vhost_conf" <<EOF
<VirtualHost *:80>
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot $docroot

    <Directory $docroot>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$domain-error.log
    CustomLog \${APACHE_LOG_DIR}/$domain-access.log combined
</VirtualHost>
EOF

    echo "Virtual host configuration created: $vhost_conf"

    # Enable the virtual host and reload Apache
    a2ensite "$domain"
    systemctl reload apache2
    echo "Virtual host enabled and Apache reloaded"
}

# Function to install SSL using Certbot
install_ssl() {
    read -p "Do you want to install SSL using Certbot? (yes/no): " install_ssl_choice
    if [[ "$install_ssl_choice" == "yes" ]]; then
        apt-get update
        apt-get install -y certbot python3-certbot-apache

        certbot --apache -d "$domain" -d "www.$domain"
        echo "SSL certificate installed successfully for $domain"
    else
        echo "Skipping SSL installation"
    fi
}

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

# Ensure Apache is installed
if ! command -v apache2 > /dev/null; then
    echo "Apache is not installed. Installing now..."
    apt-get update
    apt-get install -y apache2
fi

# Start script
echo "Starting virtual host creation..."
create_virtual_host
install_ssl

echo "Script completed."
