
## Install packer on linux mint

sudo apt install gpg
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com focal main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer


## Create template

    packer build -force -var-file="./vars/debian-12.pkrvars.hcl" conf/debian.pkr.hcl



    packer build -force --var-file=exemples/debian12.pkrvars.hcl .
