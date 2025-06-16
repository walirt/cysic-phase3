#!/bin/sh

if [ -z "${CLAIM_REWARD_ADDRESS}" ]; then
    echo "Error: CLAIM_REWARD_ADDRESS environment variable is not set or is empty"
    exit 1
fi

if [ -z "${RPC_URL}" ]; then
    echo "Error: RPC_URL environment variable is not set or is empty"
    exit 1
fi

sed -i "s#\$CLAIM_REWARD_ADDRESS#${CLAIM_REWARD_ADDRESS}#" config.yaml
sed -i "s#\$RPC_URL#${RPC_URL}#" config.yaml
echo "CLAIM_REWARD_ADDRESS: $CLAIM_REWARD_ADDRESS"
echo "RPC_URL: $RPC_URL"

exec "$@"