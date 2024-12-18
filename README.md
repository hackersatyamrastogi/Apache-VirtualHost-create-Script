# Virtual Host Setup Script

This script helps automate the process of creating virtual hosts for both HTTP (port 80) and HTTPS (port 443) on an Apache web server. It also optionally installs and configures SSL certificates using Certbot.

## Features
- Creates a virtual host for a specified domain.
- Configures the document root for the virtual host.
- Automatically enables the virtual host and reloads Apache.
- Optionally installs SSL certificates using Certbot for HTTPS.

## Requirements
- **Operating System**: Linux-based system (e.g., Ubuntu)
- **Web Server**: Apache
- **Root Privileges**: Script must be run with `sudo` or as root.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/virtual-host-setup.git
   cd virtual-host-setup
Usage
Run the script:

bash
Copy code
sudo ./create_vhost.sh
Follow the interactive prompts:

Enter the domain name (e.g., example.com).
Specify the document root (e.g., /var/www/example.com).
Choose whether to install SSL certificates using Certbot.
If you choose to install SSL, the script will install Certbot (if not already installed) and configure SSL for the specified domain.

Example
Here's an example of what the script does:

You enter example.com as the domain and /var/www/example.com as the document root.
The script:
Creates a directory for the document root (if it doesn't exist).
Configures an Apache virtual host file for example.com.
Reloads Apache to apply changes.
If you choose to install SSL:
The script installs Certbot (if necessary).
Requests and applies an SSL certificate for example.com and www.example.com.
Dependencies
Apache Web Server
Certbot for SSL (optional)
License
This project is licensed under the MIT License. See the LICENSE file for details.

Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

Issues
If you encounter any issues, feel free to open an issue.

Author
Created by Satyam Avtar Rastogi.
