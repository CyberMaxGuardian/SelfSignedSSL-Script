# Self-Signed SSL Certificate Script

This script generates a self-signed SSL certificate, merges it into a web server configuration, and creates a .p12 certificate file. The script is designed to be used in Unix-like environments and supports both nginx and apache web servers.

## Prerequisites

- OpenSSL: Ensure you have OpenSSL installed on your system.

## Usage

1. Download the script file `generate_ssl_certificate.sh` to your system.

2. Open a terminal and navigate to the directory where the script is located.

3. Run the script:

4. Follow the prompts to provide input for generating the certificate and configuring the web server.

## Script Overview

The script performs the following steps:

1. Generates a private key.
2. Prompts you to specify the validity days for the certificate.
3. Generates a self-signed certificate.
4. Combines the private key and certificate into a single PEM file.
5. Asks you to select a web server type (nginx or apache).
6. Asks you to provide the path to the SSL certificate directory.
7. Copies the generated certificate to the specified SSL certificate directory.
8. Updates the web server configuration to use the new certificate.
9. Restarts the web server to apply the changes.
10. Asks you to enter a password for the .p12 certificate file.
11. Generates a .p12 certificate file containing the private key, certificate, and chain.

## Note

- The script is a generic example and may need modifications to work with your specific web server and system configuration.
- Ensure you have the necessary permissions to modify web server configurations and restart the server.
- Use this script for development, testing, or isolated environments. In production, consider using certificates from trusted CAs.

## Disclaimer

This script is provided as-is, without any warranties or guarantees. Use it at your own risk. Always review and understand the script's content before running it.

---

*Author: Manoj Prakash*

