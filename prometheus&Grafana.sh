#!/bin/bash

## Prometheus & Grafana Dashboard installation

sudo groupadd --system prometheus

sudo useradd -s /sbin/nologin --system -g prometheus prometheus

sudo mkdir /var/lib/prometheus

for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done

sudo apt update

sudo apt -y install wget curl vim

mkdir -p /tmp/prometheus && cd /tmp/prometheus

curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

tar xvf prometheus*.tar.gz

cd prometheus*/

sudo mv prometheus promtool /usr/local/bin/

sudo mv consoles/ console_libraries/ /etc/prometheus/

cd $HOME

#sudo vim /etc/prometheus/prometheus.yml
###############################

sudo cat <<EOF> /etc/prometheus/prometheus.yml
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']
    
EOF


###############################

sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF

###############################


for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
sudo chown -R prometheus:prometheus /var/lib/prometheus/

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

sudo systemctl status prometheus

echo 'Check the Dashboard using port no. 9090'


##Installing Grafana

sudo apt-get install -y adduser libfontconfig1

wget https://dl.grafana.com/oss/release/grafana_9.4.0~beta1_amd64.deb

sudo dpkg -i grafana_9.4.0~beta1_amd64.deb

sudo /bin/systemctl daemon-reload

sudo /bin/systemctl enable grafana-server

 sudo /bin/systemctl start grafana-server

echo 'Check the Dashboard using port no. 3000'


###################################################

## Installing Node Exporter for which system you want monitor

cd /tmp 

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

tar xvfz node_exporter-*.*-amd64.tar.gz

cd node_exporter-*.*-amd64


## create a service file

sudo tee /etc/systemd/system/node_exporter.service<<EOF
[Unit]
Description=node_exporter
Documentation=https://prometheus.io/docs/introduction/overview/
After=online.target

[Service]
User=root  
Restart=on-failure

ExecStart= /tmp/node_exporter/node_exporter 

[Install]
WantedBy=multi-user.target
EOF

###############################

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

sudo systemctl status node_exporter



##############################################################################333

##Black Box configuration in promethues.yml

# - job_name: 'blackbox'
#     scrape_interval: 60s
#     metrics_path: /probe
#     params:
#       module: [http_2xx]  # Look for a HTTP 200 response.
#     static_configs:
#       - targets:
#         - https://vsk.ndear.gov.in
#         - https://vsk.schooleducationharyana.gov.in
#         - https://vsk.megeducation.gov.in
#         - https://vsk.bihar.gov.in
#         - https://vsk-ssa.assam.gov.in
#         - https://vsk.odisha.gov.in
#         - https://vsk.cg.gov.in
#         - https://vsk.scertchd.edu.in
#         - https://vskedn.andaman.gov.in
#         - https://vsk.arunachal.gov.in
#     relabel_configs:
#       - source_labels: [__address__]
#         target_label: __param_target
#       - source_labels: [__param_target]
#         target_label: instance
#       - target_label: __address__
#         replacement: vm-vsk-admin-bastion-01:9115  # The blackbox exporter's real hostname:port.

#   - job_name: Telegraf
#     # If telegraf is installed, grab stats about the local
#     # machine by default.
#     static_configs:
#       - targets: ['vm-vsk-nginx-lb-01:9125']


# #### Configure Amazon RDS in Grafana Dashboard

# URL Monitoring
# CPU 
# Memory 
# Disk
