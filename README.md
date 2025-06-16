# Cysic phase3 scripts
> If you don't have an invite code, feel free to use my 👉 **fbd44**  

English | [中文](https://github.com/walirt/cysic-phase3/blob/main/README_zh.md)

## Verifier

### Recommended configuration
```text
CPU: Any
GPU: Any
RAM: At least 4G per verifier or higher
DISK: At least 10G per verifier or higher
OS: Ubuntu 22.04 with docker installed
```

### Run with docker
[Docker Image](https://hub.docker.com/r/walirt/cysic-verifier)
```bash
docker run -e CLAIM_REWARD_ADDRESS="CLAIM REWARD ADDRESS" -d -v /YOUR_DIR/keys:/root/.cysic/keys --name cysic1 walirt/cysic-verifier:v3
docker run -e CLAIM_REWARD_ADDRESS="ANOTHER CLAIM REWARD ADDRESS" -d -v /YOUR_ANOTHER_DIR/keys:/root/.cysic/keys --name cysic2 walirt/cysic-verifier:v3
```

#### Use docker compose
first, create a `docker-compose.yml` file:
```yaml
services:
  cysic1:
    image: walirt/cysic-verifier:v3
    volumes:
      - /YOUR_DIR/keys:/root/.cysic/keys
    environment:
      CLAIM_REWARD_ADDRESS: CLAIM REWARD ADDRESS
    restart: always
  cysic2:
    image: walirt/cysic-verifier:v3
    volumes:
      - /YOUR_ANOTHER_DIR/keys:/root/.cysic/keys
    environment:
      CLAIM_REWARD_ADDRESS: ANOTHER CLAIM REWARD ADDRESS
    restart: always
```

then, run the following command:
```bash
docker compose up -d
```

## Prover

### Recommended configuration
```text
Eth prover
  CPU: Any
  GPU: 24GB VRAM or higher (3090, 3090Ti, 4090, 4090D)
  RAM: 32GB
  DISK: 100GB
  OS: Ubuntu 22.04

Scroll prover
  CPU: Any, but higher is better
  GPU: 24GB VRAM or higher (3090, 3090Ti, 4090, 4090D)
  RAM: 256GB
  DISK: 100GB
  OS: Ubuntu 22.04
```

### Run directly
```bash
apt update 
apt install -y curl
curl -L "https://raw.githubusercontent.com/walirt/cysic-phase3/main/setup_prover_warpper.sh" -o setup_prover_warpper.sh
bash setup_prover_warpper.sh
cd ~/cysic-prover
./start.sh
```

### Run with docker 
[Docker Image](https://hub.docker.com/r/walirt/cysic-prover)
```bash
# Generate new key
docker run -it -e CLAIM_REWARD_ADDRESS="YOUR CLAIM REWARD ADDRESS" -e RPC_URL="YOUR RPC URL" -d --name cysic1 cysic-prover:v3
# Mount existing key
docker run -it -e CLAIM_REWARD_ADDRESS="YOUR CLAIM REWARD ADDRESS" -e RPC_URL="YOUR RPC URL" -d -v /YOUR_DIR/keys:/root/cysic-prover/~/.cysic/assets --name cysic1 cysic-prover:v3
```

### Help
[Get Free RPC endpoint used by eth proof](https://docs.cysic.xyz/tutorial-docs/how-to-run-a-prover-node#get-free-rpc-endpoint-used-by-eth-proof)

## Contact me
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/walirttt.svg?style=social&label=Follow%20%40walirttt)](https://twitter.com/walirttt)
