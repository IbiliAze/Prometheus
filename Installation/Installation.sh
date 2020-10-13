#!/bin/bash


echo step 1
sudo useradd -M -r -s /bin/false prometheus

echo step 2
sudo mkdir /etc/prometheus /var/lib/prometheus

echo step 3
wget https://github.com/prometheus/prometheus/releases/download/v2.21.0/prometheus-2.21.0.linux-amd64.tar.gz

echo step 4
tar xzf prometheus-2.21.0.linux-amd64.tar.gz prometheus-2.21.0.linux-amd64/

echo step 5
sudo cp prometheus-2.21.0.linux-amd64/{prometheus,promtool} /usr/local/bin

echo step 6
sudo chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}

echo step 7
sudo cp -r prometheus-2.21.0.linux-amd64/{consoles,console_libraries} /etc/prometheus

echo step 8
sudo cp prometheus-2.21.0.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml

echo step 9
sudo chown -R prometheus:prometheus /etc/prometheus

echo step 10
sudo chown prometheus:prometheus /var/lib/prometheus

echo step 11
echo '''[Unit]
Description=Prometheus Server
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target''' > prometheus.service

echo step 12
sudo cp prometheus.service /etc/systemd/system/

echo step 13
sudo systemctl daemon-reload

echo step 14
sudo systemctl start prometheus

echo step 15
sudo systemctl enable prometheus

echo step 16
sudo systemctl status prometheus

echo step 17
curl localhost:9090

echo step 18
prometheus --config.file=/etc/prometheus/prometheus.yml
