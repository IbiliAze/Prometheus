#!/bin/bash


echo step 1
sudo useradd -M -r -s /bin/false pushgateway

echo step 2
wget https://github.com/prometheus/pushgateway/releases/download/v1.3.0/pushgateway-1.3.0.linux-amd64.tar.gz

echo step 3
tar xvfz pushgateway-1.3.0.linux-amd64.tar.gz

echo step 4
sudo cp pushgateway-1.3.0.linux-amd64/pushgateway /usr/local/bin/

echo step 5
sudo chown pushgateway:pushgateway /usr/local/bin/pushgateway

echo step 6
echo '''[Unit]
Description=Pushgateway
Wants=network-online.target
After=network-online.target

[Service]
User=pushgateway
Group=pushgateway
Type=simple
ExecStart=/usr/local/bin/pushgateway 

[Install]
WantedBy=multi-user.target''' >pushgateway.service

echo step 7
sudo cp pushgateway.service /etc/systemd/system/

echo step 8
sudo systemctl enable pushgateway

echo step 9
sudo systemctl start pushgateway

echo step 10
sudo systemctl status pushgateway

echo step 11
sudo curl localhost:9091/metrics

