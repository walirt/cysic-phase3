#!/bin/bash

apt update
apt install -y curl

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source  /root/.cargo/env

# install sp1up
curl -L https://sp1up.succinct.xyz | bash
source /root/.bashrc
sp1up

# download moongate-server
wget --no-check-certificate 'https://raw.githubusercontent.com/walirt/cysic-phase3/refs/heads/main/moongate-server' -O /root/moongate-server

# create fake-docker directory
mkdir -p /root/fake-docker/bin

# download fake-docker.sh
wget --no-check-certificate 'https://raw.githubusercontent.com/walirt/cysic-phase3/refs/heads/main/fake-docker.sh' -O /root/fake-docker/bin/docker
chmod +x /root/fake-docker/bin/docker
echo 'export PATH="$PATH:/root/fake-docker/bin"' >> /root/.bashrc
source /root/.bashrc

curl -L https://raw.githubusercontent.com/walirt/cysic-phase3/refs/heads/main/setup_prover.sh > ~/setup_prover.sh && bash ~/setup_prover.sh $1 $2
