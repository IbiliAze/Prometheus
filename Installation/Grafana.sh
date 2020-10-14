#!/bin/bash


echo step 1
sudo apt-get install -y apt-transport-https software-properties-common wget

echo step 2
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo step 3
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

echo step 4
sudo apt-get update -y

echo step 5
sudo apt-get install grafana

echo step 6
sudo systemctl enable grafana-server

echo step 7
sudo systemctl start grafana-server

echo step 8
sudo systemctl status grafana-server

