## Install the Cassandra Database & cassandra Reaper 
## Ubuntu 18.04 especially

sudo apt-get update -y
sudo apt install openjdk-8-jdk
sudo apt install apt-transport-https
wget curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -

sudo echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
sudo apt update
sudo apt install cassandra
nodetool status
sudo cp /etc/cassandra/cassandra.yaml /etc/cassandra/cassandra.yaml.backup
sudo nano /etc/cassandra/cassandra.yaml
    # ## Check the cluster name
    # seed _provider 
    # add the nodes ip address

wget https://github.com/thelastpickle/cassandra-reaper/releases/download/3.3.3/reaper_3.3.3_all.deb
sudo dpkg --install reaper*.deb
systemctl status cassandra-reaper
systemctl start cassandra-reaper


CREATE KEYSPACE testingout
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 1 
  };

  CREATE TABLE tabletest (
                     name TEXT PRIMARY KEY,
                     surname TEXT,
                     phone INT
                   );

INSERT INTO tabletest (name, surname, phone) 
VALUES ('John', 'Johnson', 456123789);
