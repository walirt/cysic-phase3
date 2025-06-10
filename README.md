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
GITHUB_TOKEN=GITHUB_TOKEN
curl -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3.raw" \
     -L "https://api.github.com/repos/walirt/cysic-phase3/contents/setup_prover.sh" | bash -s -- "$GITHUB_TOKEN"
```
