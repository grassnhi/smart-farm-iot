#!/bin/bash

set -e

cd ..

if [ -d "smart-farm-iot" ]; then
    echo "Removing existing smart-farm-iot directory..."
    sudo rm -r smart-farm-iot
fi

echo "Cloning smart-farm-iot from GitHub..."
git clone -b runCM4 https://github.com/grassnhi/smart-farm-iot.git

cd smart-farm-iot
chmod 777 gitBash.sh

echo "Setup completed successfully."