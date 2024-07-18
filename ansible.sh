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

echo "vi /etc/ansible/ansible.cfg
----------------------------------
[defaults]
inventory = /etc/ansible/inventory.ini
host_key_checking = False
----------------------------------

ansible-inventory --list
"

echo "ansible -m ping all"
