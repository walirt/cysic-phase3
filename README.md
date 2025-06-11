# Cysic phase3 scripts
| If you don't have an invite code, feel free to use my 👉 **fbd44**

## Verifier (with Docker)
[Docker Image](https://hub.docker.com/r/walirt/cysic-verifier)

### Recommended configuration
```text
CPU: Any
GPU: Any
RAM: At least 4G per verifier or higher
DISK: At least 10G per verifier or higher
OS: Ubuntu 22.04 with docker installed
```

### Run directly
```bash
docker run -e CLAIM_REWARD_ADDRESS="CLAIM REWARD ADDRESS" -d -v /YOUR_DIR/keys:/root/.cysic/keys --name cysic1 walirt/cysic-verifier:v3
docker run -e CLAIM_REWARD_ADDRESS="ANOTHER CLAIM REWARD ADDRESS" -d -v /YOUR_ANOTHER_DIR/keys:/root/.cysic/keys --name cysic2 walirt/cysic-verifier:v3
```

### Run with docker compose
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

## Prover (without docker)

### Recommended configuration
```text
CPU: Any
GPU: 24GB VRAM or higher (3090, 3090Ti, 4090, 4090D)
RAM: 32GB
DISK: 100GB
OS: Ubuntu 22.04
```

### Run
```bash
apt update 
apt install -y curl
GITHUB_TOKEN=GITHUB_TOKEN
curl -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3.raw" \
     -L "https://api.github.com/repos/walirt/cysic-phase3/contents/setup_prover_warpper.sh"
     -o setup_prover_warpper.sh
bash setup_prover_warpper.sh $GITHUB_TOKEN
cd ~/cysic-prover
./start.sh
```
