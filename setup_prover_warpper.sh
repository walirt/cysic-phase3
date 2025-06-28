#!/bin/bash

# 检查是否使用-s参数
SKIP_PROMPT=false
while getopts "s" opt; do
  case $opt in
    s)
      SKIP_PROMPT=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

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
chmod +x ~/moongate-server
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

if [ "$SKIP_PROMPT" = false ]; then
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
else
    CLAIM_REWARD_ADDRESS="\$CLAIM_REWARD_ADDRESS"
    RPC_URL="\$RPC_URL"
fi
echo

echo "-----Executing setup_prover.sh-----"
bash ~/setup_prover.sh $CLAIM_REWARD_ADDRESS $RPC_URL
echo

echo '-----Modify start.sh-----'
cat <<EOF >~/cysic-prover/start.sh
#!/bin/bash

export PATH="\$PATH:$HOME/fake-docker/bin"
export SP1_PROVER=cuda 
export LD_LIBRARY_PATH=. 
export CHAIN_ID=534352
until ./prover; do
    echo "Prover exited with code \$?. Restarting in 3 seconds..."
    sleep 3
done
echo "Prover stopped."
EOF
chmod +x ~/cysic-prover/start.sh
echo 'Done'
