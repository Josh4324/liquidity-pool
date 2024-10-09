// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract LiquidityPool is ERC4626, Ownable {
    IERC20 public underlyingToken;

    // ERC4626 constructor: Underlying token, Vault Token (e.g., "LP Token", "LPT")
    constructor(address _underlyingToken)
        ERC4626(IERC20(_underlyingToken))
        ERC20("Liquidity Pool Token", "LPT")
        Ownable(msg.sender)
    {
        underlyingToken =  IERC20(_underlyingToken);
    }

    // Function to deposit tokens into the pool
    function deposit(uint256 assets, address receiver) public override returns (uint256) {
        require(assets > 0, "Cannot deposit 0 assets");
        return super.deposit(assets, receiver);
    }

    // Function to withdraw tokens from the pool
    function withdraw(uint256 assets, address receiver, address owner) public override returns (uint256) {
        return super.withdraw(assets, receiver, owner);
    }

    // Example function: Simulate adding yield to the pool
    function addYield(uint256 amount) external onlyOwner {
        underlyingToken.transferFrom(msg.sender, address(this), amount);
    }
    
    // Returns the total amount of underlying assets (ERC20 tokens) in the pool
    function totalAssets() public view override returns (uint256) {
        return underlyingToken.balanceOf(address(this));
    }
}
