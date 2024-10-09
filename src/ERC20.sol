// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    // Initial supply is passed in constructor during deployment
    constructor(uint256 initialSupply) ERC20("My Token", "MTK") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * (10 ** decimals()));
    }

    // Mint new tokens (Only owner can call this)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens (Only owner can call this)
    function burn(uint256 amount) public onlyOwner {
        _burn(msg.sender, amount);
    }
}
