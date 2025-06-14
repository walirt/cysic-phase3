#!/bin/bash

echo "-----Installing rust-----"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ~/.cargo/env
echo

echo "-----Installing sp1up-----"
curl -L https://sp1up.succinct.xyz | bash
source ~/.bashrc
~/.sp1/bin/sp1up
echo

echo "-----Downloading moongate-server-----"
curl -L "https://raw.githubusercontent.com/walirt/cysic-phase3/main/moongate-server" \
     -o ~/moongate-server
echo

echo "-----Creating fake-docker directory-----"
mkdir -p ~/fake-docker/bin
echo

echo "-----Downloading fake-docker.sh-----"
curl -L "https://raw.githubusercontent.com/walirt/cysic-phase3/main/fake-docker.sh" \
     -o ~/fake-docker/bin/docker
chmod +x ~/fake-docker/bin/docker
echo

echo "-----Downloading setup_prover.sh-----"
curl -L "https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/setup_prover.sh" \
     -o ~/setup_prover.sh
sed -i '/# 询问用户是否运行 eth_dependency.sh/,/esac/d' ~/setup_prover.sh
echo

echo "-----Prompting-----"
read -p "👉 Please enter your CLAIM_REWARD_ADDRESS: " CLAIM_REWARD_ADDRESS

if [[ ! $CLAIM_REWARD_ADDRESS =~ ^0x[a-fA-F0-9]{40}$ ]]; then
    echo "Error: Invalid Ethereum address format"
    exit 1
fi

read -p "👉 Please enter your RPC_URL: " RPC_URL

if [[ ! $RPC_URL =~ ^https?:// ]]; then
    echo "Error: Invalid RPC URL format"
    exit 1
fi
echo

echo "-----Executing setup_prover.sh-----"
bash ~/setup_prover.sh $CLAIM_REWARD_ADDRESS $RPC_URL
echo

echo '-----Modify start.sh-----'
sed -i '1i export PATH="$PATH:~/fake-docker/bin"' ~/cysic-prover/start.sh
echo 'Done'
