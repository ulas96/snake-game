// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    address public owner;
    uint public value;
    uint public totalGames;
    uint public totalPendingGames;

    struct PendingGame {
        address gameCreator;
        uint snakeLength;
        uint value;
        uint timestamp;
    }

    struct Game {
        address opt1;
        uint snakeLength1;
        address opt2;
        uint snakeLength2;
        uint value;
        uint timestamp;
    }

    constructor(uint _value) {
        value = _value;
        owner = msg.sender;
        totalGames = 0;
        totalPendingGames = 0;
    }
}
