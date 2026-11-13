#!/bin/bash

if systemctl is-active --quiet apache2

then
    echo "Apache server is running"
else
    echo "Apache server is not running"
fi
