# Local environment setup

## 1. Setup Node/NPM environment
1 open new terminal window
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
This install homebrew

2 install node/npm, yarn by using ```brew``` 
```
brew install node
brew install yarn
```
3 make sure you have node and npm installed by running simple commands to see what version of each ins installed
```
node -v
npm -v
```

## 2. Install Rust environment
open terminal and type below command
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## 3. Install Hardhat for solidity smart contract dev environment
npm install -g hardhat

## 4. Install Docker for Geth node 

```
sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce

sudo systemctl status docker
```

# Run the project
1.we are going to use bundler, and smart contract repo of soul wallet. And our rust library repo

```
git clone https://github.com/proofofsoulprotocol/soul-wallet-contract

git clone https://github.com/proofofsoulprotocol/bundler
```

Clone our rust library repo
```
https://github.com/clutch-wallet/clutch-browser-extension-consumer-lib.git
```

2. Run Geth
It will download geth docker image and run docker container
```
docker run --rm -ti --name geth -p 8545:8545 ethereum/client-go:v1.10.26 \
  --miner.gaslimit 12000000 \
  --http --http.api personal,eth,net,web3,debug \
  --http.vhosts '*,localhost,host.docker.internal' --http.addr "0.0.0.0" \
  --ignore-legacy-receipts --allow-insecure-unlock --rpc.allow-unprotected-txs \
  --dev \
  --verbosity 2 \
  --nodiscover --maxpeers 0 --mine --miner.threads 1 \
  --networkid 1337
```

3. Deploy smart contract for bundler and run bunderl service
```
cd bundler
yarn hardhat-deploy --network localhost
yarn run bundler
```

4. Deploy smart contract for wallet

***You need env infomation to configure the smart conract
```
cd soul-wallet-contract

source .env && forge script script/SingletonFactory.s.sol:SingletonFactory --ffi --rpc-url $RPC_URL --broadcast

source .env && forge script script/KeystoreDeployer.s.sol:KeystoreDeployer --ffi --rpc-url $RPC_URL --broadcast

source .env && forge script script/WalletDeployer.s.sol:WalletDeployer --ffi --rpc-url $RPC_URL --broadcast

source .env && forge script script/PaymasterDeployer.s.sol:PaymasterDeployer --ffi --rpc-url $RPC_URL --broadcast
```

Now you can test rust library code