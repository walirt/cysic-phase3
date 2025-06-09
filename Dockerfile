FROM ubuntu:22.04

RUN apt update && \
    apt install -y build-essential curl && \
    mkdir /root/cysic-verifier && \
    curl -L  https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/verifier_linux > /root/cysic-verifier/verifier && \
    curl -L https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/libdarwin_verifier.so > /root/cysic-verifier/libdarwin_verifier.so && \
    curl -L https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/librsp.so > /root/cysic-verifier/librsp.so

WORKDIR /root/cysic-verifier

RUN cat <<EOF > /root/cysic-verifier/config.yaml
# Not Change
chain:
  # Not Change
  endpoint: "grpc-testnet.prover.xyz:80"
  # Not Change
  chain_id: "cysicmint_9001-1"
  # Not Change
  gas_coin: "CYS"
  # Not Change
  gas_price: 10
  # Modify Here：! Your Address (EVM) submitted to claim rewards
claim_reward_address: "\$CLAIM_REWARD_ADDRESS"

server:
  # don't modify this
  cysic_endpoint: "https://ws-pre.prover.xyz"
EOF

COPY entrypoint.sh .

ENV LD_LIBRARY_PATH=/root/cysic-verifier CHAIN_ID=534352

RUN chmod +x entrypoint.sh && \
    chmod +x verifier 

CMD ["./entrypoint.sh", "./verifier"]