#!/bin/bash
echo "Installing the application..." > /tmp/install.log
# Simulate installation steps
sleep 2
if [ -f /etc/os-release ]; then
	. /etc/os-release
	if [[ "$ID" == "fedora" || "$ID" == "rhel" || "$ID_LIKE" == *"rhel"* ]]; then
		yum install -y tcl-8.6.8-2.el8.x86_64 && yum remove tcl-8.6.8-2.el8.i686 -y
		yum install -y nginx
	else
		apt install -y nginx
	fi
else
	echo "Skipping yum commands: OS information not found." >> /tmp/install.log
fi

# Configure nginx
cat > /etc/nginx/sites-available/proxy.conf << 'EOF'
server {
    listen 11111;
    server_name _;

    location /opengrok {
        proxy_pass https://opengrok.checkpoint.com:8443;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_ssl_verify off;
    }

    location /perkins {
        proxy_pass https://perkins.checkpoint.com:8443;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_ssl_verify off;
    }
}
EOF

# Enable the configuration
if [ -d /etc/nginx/sites-enabled ]; then
    ln -sf /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/
elif [ -d /etc/nginx/conf.d ]; then
    cp /etc/nginx/sites-available/proxy.conf /etc/nginx/conf.d/proxy.conf
fi

# Test nginx configuration and restart
nginx -t && systemctl restart nginx
echo "Installation complete!" >> /tmp/install.log
echo "Installation complete!"