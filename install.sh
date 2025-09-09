#!/bin/bash
echo "Installing the application..." > /tmp/install.log
# Simulate installation steps
sleep 2
echo "Installation complete!" >> /tmp/install.log
yum install -y tcl-8.6.8-2.el8.x86_64 && yum remove tcl-8.6.8-2.el8.i686 -y
echo "Installation complete!"