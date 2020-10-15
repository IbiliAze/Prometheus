#!/bin/bash


echo step 1
echo '''name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt''' >grafana.repo

echo step 2
sudo cp grafana.repo /etc/yum.repos.d/

echo step 3
sudo yum update -y

echo step 4
sudo yum install -y grafana

echo step 5
sudo systemctl start grafana-server

echo step 6
sudo systemctl enable grafana-server

echo step 7
sudo systemctl status grafana-server

