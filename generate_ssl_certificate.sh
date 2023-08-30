#!/bin/bash

# Generate a private key
openssl genpkey -algorithm RSA -out private.key

# Read the validity days from the user
read -p "Enter the validity days for the certificate: " validity_days

# Generate a self-signed certificate with the provided validity days
openssl req -new -x509 -key private.key -out certificate.crt -days "$validity_days"

# Combine private key and certificate into a single PEM file
cat private.key certificate.crt > server.pem

# Ask the user to select a web server type
read -p "Select the web server type (nginx/apache): " web_server_type

# Ask the user to provide the SSL certificate directory path
read -p "Enter the path to the SSL certificate directory: " ssl_cert_dir

# Path to the web server's configuration file
config_file=""
restart_command=""

case "$web_server_type" in
    nginx)
        config_file="/etc/nginx/nginx.conf"  
        restart_command="service nginx restart"  
        ;;
    apache)
        config_file="/etc/apache2/httpd.conf"  
        restart_command="service apache2 restart"  
        ;;
    *)
        echo "Invalid web server type. Exiting."
        exit 1
        ;;
esac

# Copy the generated certificate to the SSL/TLS certificates directory
cp server.pem "$ssl_cert_dir/server.pem"

# Update the web server's configuration to use the new certificate
# This is a generic example; actual steps might differ based on the web server
sed -i "s|ssl_certificate .*|ssl_certificate $ssl_cert_dir/server.pem;|" "$config_file"
sed -i "s|ssl_certificate_key .*|ssl_certificate_key $ssl_cert_dir/private.key;|" "$config_file"

# Restart the web server to apply the changes
eval "$restart_command"

# Generate a PKCS#12 (.p12) certificate
read -p "Enter a password for the .p12 file: " p12_password
openssl pkcs12 -export -out certificate.p12 -inkey private.key -in certificate.crt -certfile server.pem -passout pass:"$p12_password"

echo "Certificate merged into web server configuration and .p12 file generated successfully."
