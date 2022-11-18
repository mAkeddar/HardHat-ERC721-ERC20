// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

// Uncomment this line to use console.log
 import "hardhat/console.sol";

 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 contract Xeu is ERC20{

    constructor()ERC20('XeuToken','XEU'){

    }

    function wonCombat(address winner) external{
        _mint(winner,10 ether);
    }

 }





