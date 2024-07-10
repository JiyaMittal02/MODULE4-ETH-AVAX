// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. 
//The smart contract should have the following functionality:
// 1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. 
//    Only the owner can mint tokens.
// 2. Transferring tokens: Players should be able to transfer their tokens to others.
// 3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// 4. Checking token balance: Players should be able to check their token balance at any time.
// 5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract AcademicToken is ERC20, Ownable, ERC20Burnable {

    // Constructor initializing ERC20 and Ownable
    constructor() ERC20("Academic", "ACD") Ownable(msg.sender) {
        // Initial minting to contract deployer
        _mint(msg.sender, 5000 * 10 ** decimals());
    }

    enum SubjectLevel { Beginner, Intermediate, Advanced, Expert, Master }

    struct Purchaser {
        address purchaserAddress;
        uint256 tokenAmount;
    }

    Purchaser[] public purchaserQueue;

    struct SubjectCollection {
        uint256 beginner;
        uint256 intermediate;
        uint256 advanced;
        uint256 expert;
        uint256 master;
    }

    mapping(address => SubjectCollection) public userSubjects;

    function buyTokens(address purchaserAddress, uint256 tokenAmount) public {
        require(purchaserAddress != address(0), "Invalid address");
        require(tokenAmount > 0, "Invalid token amount");
        purchaserQueue.push(Purchaser({purchaserAddress: purchaserAddress, tokenAmount: tokenAmount}));
    }

    function distributeTokens() public onlyOwner {
        uint256 queueLength = purchaserQueue.length;
        while (queueLength > 0) {
            Purchaser memory lastPurchaser = purchaserQueue[queueLength - 1];
            _mint(lastPurchaser.purchaserAddress, lastPurchaser.tokenAmount);
            purchaserQueue.pop();
            queueLength--;
        }
    }

    function transferFunds(address recipient, uint256 amount) public {
        require(recipient != address(0), "Invalid recipient address");
        require(amount <= balanceOf(msg.sender), "Insufficient balance");
        _transfer(msg.sender, recipient, amount);
    }

    function exchangeForSubject(SubjectLevel level) public {
        uint256 cost = getSubjectCost(level);
        require(balanceOf(msg.sender) >= cost, "Insufficient tokens to exchange for subject");

        if (level == SubjectLevel.Beginner) {
            userSubjects[msg.sender].beginner += 1;
        } else if (level == SubjectLevel.Intermediate) {
            userSubjects[msg.sender].intermediate += 1;
        } else if (level == SubjectLevel.Advanced) {
            userSubjects[msg.sender].advanced += 1;
        } else if (level == SubjectLevel.Expert) {
            userSubjects[msg.sender].expert += 1;
        } else if (level == SubjectLevel.Master) {
            userSubjects[msg.sender].master += 1;
        }
        burn(cost);
    }
    
    function burnUserTokens(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }

    function checkTokenBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function getSubjectCost(SubjectLevel level) internal pure returns (uint256) {
        if (level == SubjectLevel.Beginner) {
            return 15;
        } else if (level == SubjectLevel.Intermediate) {
            return 30;
        } else if (level == SubjectLevel.Advanced) {
            return 45;
        } else if (level == SubjectLevel.Expert) {
            return 60;
        } else if (level == SubjectLevel.Master) {
            return 75;
        } else {
            revert("Invalid subject level");
        }
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount);
        return true;
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
}
