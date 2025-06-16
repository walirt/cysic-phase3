# Cysic phase3 脚本
> 如果你没有邀请码，欢迎使用我的 👉 **fbd44**

[English](https://github.com/walirt/cysic-phase3/blob/main/README.md) | 中文

## Verifier

### 推荐配置
```text
CPU: 任意
GPU: 任意
内存: 每个验证器至少 4G 或更高
硬盘: 每个验证器至少 10G 或更高
操作系统: Ubuntu 22.04 并安装 Docker
```

### 使用 Docker 运行
[Docker 镜像](https://hub.docker.com/r/walirt/cysic-verifier)
```bash
docker run -e CLAIM_REWARD_ADDRESS="奖励地址" -d -v /你的目录/keys:/root/.cysic/keys --name cysic1 walirt/cysic-verifier:v3
docker run -e CLAIM_REWARD_ADDRESS="另一个奖励地址" -d -v /你的另一个目录/keys:/root/.cysic/keys --name cysic2 walirt/cysic-verifier:v3
```

#### 使用 docker compose
首先，创建一个 `docker-compose.yml` 文件：
```yaml
services:
  cysic1:
    image: walirt/cysic-verifier:v3
    volumes:
      - /你的目录/keys:/root/.cysic/keys
    environment:
      CLAIM_REWARD_ADDRESS: 奖励地址
    restart: always
  cysic2:
    image: walirt/cysic-verifier:v3
    volumes:
      - /你的另一个目录/keys:/root/.cysic/keys
    environment:
      CLAIM_REWARD_ADDRESS: 另一个奖励地址
    restart: always
```

然后，运行以下命令：
```bash
docker compose up -d
```

## Prover

### 推荐配置
```text
Eth prover
  CPU: 任意
  GPU: 24GB 显存或更高 (3090, 3090Ti, 4090, 4090D)
  内存: 32GB
  硬盘: 100GB
  操作系统: Ubuntu 22.04

Scroll prover
  CPU: 任意，但越高越好
  GPU: 24GB 显存或更高 (3090, 3090Ti, 4090, 4090D)
  内存: 256GB
  硬盘: 100GB
  操作系统: Ubuntu 22.04
```

### 直接运行
```bash
apt update 
apt install -y curl
curl -L "https://raw.githubusercontent.com/walirt/cysic-phase3/main/setup_prover_warpper.sh" -o setup_prover_warpper.sh
bash setup_prover_warpper.sh
cd ~/cysic-prover
./start.sh
```

### 使用 Docker 运行
[Docker 镜像](https://hub.docker.com/r/walirt/cysic-verifier)
```bash
# 生成新key
docker run -it -e CLAIM_REWARD_ADDRESS="你的奖励地址" -e RPC_URL="你的 RPC URL" -d --name cysic1 cysic-prover:v3
# 挂载已有key
docker run -it -e CLAIM_REWARD_ADDRESS="你的奖励地址" -e RPC_URL="你的 RPC URL" -d -v /你的目录/keys:/root/cysic-prover/~/.cysic/assets --name cysic1 cysic-prover:v3
```

### 帮助
[如何获取Eth prover的RPC链接](https://docs.cysic.xyz/tutorial-docs/how-to-run-a-prover-node#get-free-rpc-endpoint-used-by-eth-proof)

## 联系我
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/walirttt.svg?style=social&label=Follow%20%40walirttt)](https://twitter.com/walirttt)
