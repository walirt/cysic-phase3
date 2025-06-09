# Cysic phase3 scripts

## Verifier (with Docker)
| [Docker Image](https://hub.docker.com/r/walirt/cysic-verifier)

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
```bash
curl -L https://raw.githubusercontent.com/walirt/cysic-phase3/refs/heads/main/setup_prover.sh > ~/setup_prover.sh && bash ~/setup_prover.sh $1 $2
```
