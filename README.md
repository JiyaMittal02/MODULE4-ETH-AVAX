
# AcademicToken Smart Contract

## Overview

The `AcademicToken` contract is an ERC20 token designed for deployment on the Avalanche network, specifically for the Degen Gaming platform. This smart contract includes functionalities for minting tokens, transferring tokens, redeeming tokens for various subjects, and burning tokens. The contract is implemented using OpenZeppelin's libraries to ensure reliability and security.

### Features of the Contract

**Token Initialization:**
- **Name and Symbol**: The token is initialized with the name "Academic" and the symbol "ACD".
- **Owner**: The deployer of the contract is set as the initial owner and has special privileges.

**Token Minting:**
- **Minting Tokens**: The platform owner can mint new tokens and distribute them to players. This is achieved by the `distributeTokens` function which mints tokens to addresses in a queue.

**Token Transfer:**
- **Transfer Funds**: Players can transfer their tokens to other addresses using the `transferFunds` function. Standard ERC20 `transfer`, `transferFrom`, and `approve` methods are also included.

**Token Burning:**
- **Burning Tokens**: Users can burn their own tokens using the built-in `burn` method. Additionally, the contract owner can burn tokens from any address using the `burnUserTokens` function.

**Redemption:**
- **Redeeming Tokens**: Players can redeem their tokens for various types of subjects (Beginner, Intermediate, Advanced, Expert, Master). Each subject has a specific cost in tokens, managed by the `exchangeForSubject` function.

**Balance Check:**
- **Checking Balance**: Users can check their token balance using the `checkTokenBalance` function.

### Usage

**Deploying the Contract:**
- **Initial Setup**: The deployer is automatically set as the owner.
- **Deployment**: Use a Solidity-compatible environment like Remix IDE or Hardhat to deploy the contract on the Avalanche network.

**Purchasing Tokens:**
- **Method**: Call the `buyTokens` function with the recipient's address and the amount of tokens to be purchased.

**Minting Tokens:**
- **Method**: The owner can mint tokens for all queued buyers by calling the `distributeTokens` function.

**Transferring Tokens:**
- **Method**: Use the `transferFunds` function to send tokens. Standard ERC20 methods (`transfer`, `transferFrom`, and `approve`) are also available for token transfers.

**Redeeming Tokens:**
- **Method**: Use the `exchangeForSubject` function to redeem tokens for different subjects. Ensure you have enough tokens to cover the cost of the desired subject.

**Burning Tokens:**
- **Method**: Users can burn their own tokens using the `burn` method. The owner can burn tokens from any account by calling the `burnUserTokens` function.

**Checking Balance:**
- **Method**: Call the `checkTokenBalance` function to view your current token balance.

### Security Considerations

- **OnlyOwner**: Functions that should only be accessible by the contract owner are restricted with the `onlyOwner` modifier to prevent unauthorized access.
- **Require Statements**: Various `require` statements ensure valid inputs and sufficient balances to prevent errors.
- **OpenZeppelin Libraries**: The contract utilizes well-tested and secure implementations from OpenZeppelin to minimize risks and vulnerabilities.

## License

This project is licensed under the MIT License 

## Author

- **Jiya Mittal** 

