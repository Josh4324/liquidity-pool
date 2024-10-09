// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {LiquidityPool} from "../src/Vault.sol";
import {MyToken} from "../src/ERC20.sol";


contract VaultTest is Test {
    LiquidityPool public vault;
    MyToken public token;
    address owner = makeAddr("owner");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");
    address user3 = makeAddr("user3");

    function setUp() public {
        vm.startPrank(owner);
        token = new  MyToken(1_000_000 ether);
        vault = new LiquidityPool(address(token));

        token.mint(user1, 50 ether);
        token.mint(user2, 50 ether);
        token.mint(user3, 50 ether);
        vm.stopPrank();
    }

    function test_e2e() public {
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether, user1);
        vm.stopPrank();


        vm.startPrank(user2);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether, user2);
        vm.stopPrank();


        vm.startPrank(user3);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether, user3);
        vm.stopPrank();


        vm.startPrank(owner);
        token.approve(address(vault), 150 ether);
        vault.addYield(150 ether);
        vm.stopPrank();


        vm.startPrank(user1);
        vault.withdraw(99 ether, user1, user1);
        vm.stopPrank();

        console.log(token.balanceOf(user1));

    }

    
}
