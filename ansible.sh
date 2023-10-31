sudo apt-get update -y
sudo apt-get install ansible -y
sudo apt-get install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
sudo apt remove ansible
sudo apt install ansible -y
ansible --version

adduser ansible
passwd ubuntu@123
usermod -aG sudo ansible [[ For sudo permission]]

