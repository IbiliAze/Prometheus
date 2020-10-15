#!/bin/bash


echo step 1
sudo useradd -M -r -s /bin/false alertmanager

echo step 2
wget https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanager-0.21.0.linux-amd64.tar.gz

echo step 3
tar xvfz alertmanager-0.21.0.linux-amd64.tar.gz

echo step 4
sudo cp alertmanager-0.21.0.linux-amd64/{alertmanager,amtool} /usr/local/bin/

echo step 5
sudo chown alertmanager:alertmanager /usr/local/bin/{alertmanager,amtool}

echo step 6
sudo mkdir -p /etc/alertmanager

echo step 7
sudo cp alertmanager-0.21.0.linux-amd64/alertmanager.yml /etc/alertmanager/

echo step 8
sudo chown -R alertmanager:alertmanager /etc/alertmanager/

echo step 9
sudo mkdir -p /var/lib/alertmanager

echo step 10
sudo chown alertmanager:alertmanager /var/lib/alertmanager/

echo step 11
sudo mkdir -p /etc/amtool

echo step 12
sudo echo '''alertmanager.url: http://localhost:9093'''> config.yml
sudo cp config.yml /etc/amtool/

echo step 13
echo '''[Unit]
Description=Alert Manager
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=alertmanager
Group=alertmanager
ExecStart=/usr/local/bin/alertmanager \
  --config.file=/etc/alertmanager/alertmanager.yml \
  --storage.path=/var/lib/alertmanager/

[Install]
WantedBy=multi-user.target''' >alertmanager.service

echo step 14
sudo cp alertmanager.service /etc/systemd/system/

echo step 15
sudo systemctl start alertmanager

echo step 16
sudo systemctl enable alertmanager

echo step 17
sudo systemctl status alertmanager

echo step 18
curl localhost:9093

echo step 19
amtool config show

