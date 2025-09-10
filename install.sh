#!/bin/bash
echo "Installing the application..." > /tmp/install.log
# Simulate installation steps
sleep 2
if [ -f /etc/os-release ]; then
	. /etc/os-release
	if [[ "$ID" == "fedora" || "$ID" == "rhel" || "$ID_LIKE" == *"rhel"* ]]; then
		yum install -y tcl-8.6.8-2.el8.x86_64 && yum remove tcl-8.6.8-2.el8.i686 -y
	fi
else
	echo "Skipping yum commands: OS information not found." >> /tmp/install.log
fi
echo "Installation complete!" >> /tmp/install.log
echo "Installation complete!"