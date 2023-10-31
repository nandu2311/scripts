#!/bin/bash

# Installing Alertmanager in Ubuntu 22.04

cd /tmp
wget https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-amd64.tar.gz
tar -zvxf alertmanager-0.25.0.linux-amd64.tar.gz
sudo mv -v alertmanager-0.25.0.linux-amd64 alertmanager
cd alertmanager
cp alertmanager /usr/local/bin/
cp amtool /usr/local/bin/
cp /tmp/alertmanager/alertmanager.yml /etc/prometheus/
sudo mkdir -p /etc/prometheus/alertmanager/data

###############################

sudo tee /etc/systemd/system/alertmanager.service<<EOF
[Unit]
Description=Alertmanager for prometheus

[Service]
User=prometheus
ExecStart=/usr/local/bin/alertmanager --config.file=/etc/prometheus/alertmanager.yml --storage.path=/etc/prometheus/alertmanager/data --cluster.advertise-address=178.31.40.235:9093

[Install]
WantedBy=multi-user.target
EOF

###############################

sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager
sudo systemctl status alertmanager

