# Tokenized Real Estate

## Overview

This project demonstrates how to tokenize real estate using blockchain technology. A real estate asset is represented as an **ERC-721 NFT**, and ownership can be fractionalized into **ERC-20 tokens**, allowing multiple users to own a portion of the asset.

## Project Structure

### 1. **Smart Contracts**

- **ERC-721 Real Estate Contract**: Represents a unique real estate property.
- **ERC-20 Fractionalization Contract**: Allows the ERC-721 token to be fractionalized into ERC-20 tokens, enabling shared ownership.

### 2. **Deployment Script**

- Automates the deployment of both contracts on a blockchain network.

### 3. **Test Cases**

- Unit tests for both the **ERC-721** and **ERC-20** contracts.
- Tests for the **deployment script** to ensure proper setup.

### 4. **Makefile**

- Simplifies common development tasks such as compiling, testing, and deploying the contracts.

## Installation & Setup

### Prerequisites

Ensure you have the following installed:

- [Foundry](https://getfoundry.sh/) (for Solidity development)
- [Node.js](https://nodejs.org/) & [NPM](https://www.npmjs.com/) (for scripting and dependencies)
- MetaMask or another Web3 wallet

### Clone the Repository

```sh
git clone https://github.com/9twy/Real-Estate-Tokenization.git
cd tokenized-real-estate
```

### Install Dependencies

```sh
npm install
```

## Compilation

Use the Makefile to compile the contracts:

```sh
make build
```

## Running Tests

Execute unit tests using:

```sh
make test
```

## Deployment

Deploy the contracts using the provided script:

```sh
make deploy
```

Alternatively, run manually:

```sh
forge script script/Deploy.s.sol --rpc-url YOUR_RPC_URL --private-key YOUR_PRIVATE_KEY --broadcast
```

## Interacting with the Contracts

Once deployed, you can interact with the contracts using:

- **Etherscan (Read/Write Contract Section)**
- **Foundry's Cast tool**
- **Ethers.js or Web3.js scripts**

### Checking Token URI (Metadata)

If you own an ERC-721 real estate NFT, retrieve its metadata:

```sh
cast call CONTRACT_ADDRESS "tokenURI(uint256)" 1 --rpc-url YOUR_RPC_URL
```

### Fractionalizing the Real Estate NFT

1. Approve the ERC-20 contract to handle your ERC-721 token.
2. Lock the NFT in the contract.
3. Receive fractional ERC-20 tokens representing shares.
