## Elastic Seach Installation Steps

sudo apt-get update -y

sudo apt-get install openjdk-11-jdk -y
sudo apt-get install wget curl gnupg2 apt-transport-https -y

# check java version
java -version

## Install and configure ElasticSearch on Ubuntu

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg



echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list


sudo apt-get update -y

sudo apt-get install -y elasticsearch

## Do Modification on elastic search

sudo nano /etc/elasticsearch/elasticsearch.yml

## Change this
---Network Section---
network.host: localhost ## private ip
http.port: 9200 

# add this line
--- Discovery ---
discovery.type: single-node

# Change this values from true to false
xpack.security.enabled: false

#save config file and exit

# start the elasticsearch service
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl status elasticsearch


##################################################################

##Install and configure Kibana

sudo apt-get install kibana

## Do modification on kibana configuration file

sudo nano /etc/kibana/kibana.yml

# Remove '#' in the below lines;
server.port: 5601
server.host: "0.0.0.0" (Provide private ip)
elasticsearch.host: ["http://localhost:9200"]

# save this configuration file and  exit

# start the kibana service

sudo systemctl start kibana
sudo systemctl enable kibana
sudo systemctl status kibana

####################################################

# Installing and Configure Logstash on ubuntu

sudo apt-get install logstash -y

# Create the below config file and insert below line to load logstash beat;
sudo tee /etc/logstash/conf.d/2-beats-input.conf <<EOF

input {
    beats {
        port => 5044
    }
}

EOF

sudo tee /etc/logstash/conf.d/2-elasticsearch-output.conf <<EOF

output {
    elasticsearch {
        hosts => ["localhost:9200"]
        manage_template => false
        index => "%{[@metadata][beat]}-%{[@metadata][version]}-%[+YYYY.MM.dd]"
    }
}
EOF

# start the service for logstash
sudo systemctl start  logstash
sudo systemctl enable logstash

sudo systemctl status logstash


#################################################################################33
# Install and configure Filebeat on ubuntu
sudo apt-get install filebeat

# Do modification on filebeat configuration file;
sudo nano /etc/filebeat/filebeat.yml

# comment the below lines

Output.elasticsearch:
    Array of hosts to connect to.
    hosts: ["localhost:9200"]

#Uncomment the below lines
output.logstash:
hosts: ["localhost:5044"]

# Start the Filebeat Service
sudo systemctl start filebeat
sudo systemctl enable filebeat
sudo systemctl status filebeat

# Enable filebeat system module
sudo filebeat modules enable system

# Enable filebeat logstash module
sudo filebeat modules enable logstash

sudo filebeat modules enable kibana

### Load the Index Template;
filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'

sudo service filebeat start

## Check whether elasticsearch is receiving datalog from filebeat
curl -XGET http://localhost:9200/_cat/indicas?v

sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost"]'

sudo filebeat modules enable system

sudo filebeat modules enable apache

systemctl restart filebeat.service

filebeat test output

## Access the Kibana Web interface by using URL

echo http://locahost:5601

3.110.174.230:5601/app/home#/