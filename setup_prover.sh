#!/bin/bash

# Check if token is provided
if [ -z "$1" ]; then
    echo "Error: GitHub token is required"
    echo "Usage: $0 <github_token>"
    exit 1
fi

GITHUB_TOKEN=$1

apt update
apt install -y curl

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source  /root/.cargo/env

# install sp1up
curl -L https://sp1up.succinct.xyz | bash
source /root/.bashrc
sp1up

# download moongate-server with GitHub token
curl -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3.raw" \
     -L "https://api.github.com/repos/walirt/cysic-phase3/contents/moongate-server" \
     -o /root/moongate-server

# create fake-docker directory
mkdir -p /root/fake-docker/bin

# download fake-docker.sh with GitHub token
curl -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3.raw" \
     -L "https://api.github.com/repos/walirt/cysic-phase3/contents/fake-docker.sh" \
     -o /root/fake-docker/bin/docker
chmod +x /root/fake-docker/bin/docker
echo 'export PATH="$PATH:/root/fake-docker/bin"' >> /root/.bashrc
source /root/.bashrc

# Download setup_prover.sh
curl -L "https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/setup_prover.sh" \
     -o ~/setup_prover.sh

# Prompt for CLAIM_REWARD_ADDRESS
echo "Please enter your CLAIM_REWARD_ADDRESS:"
read CLAIM_REWARD_ADDRESS

# Validate CLAIM_REWARD_ADDRESS (basic Ethereum address format check)
if [[ ! $CLAIM_REWARD_ADDRESS =~ ^0x[a-fA-F0-9]{40}$ ]]; then
    echo "Error: Invalid Ethereum address format"
    exit 1
fi

# Prompt for RPC_URL
echo "Please enter your RPC_URL:"
read RPC_URL

# Basic validation for RPC_URL
if [[ ! $RPC_URL =~ ^https?:// ]]; then
    echo "Error: Invalid RPC URL format"
    exit 1
fi

# Execute setup_prover.sh with all parameters
bash ~/setup_prover.sh $CLAIM_REWARD_ADDRESS $RPC_URL
