// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


contract Snake {
    address public owner;
    uint public amount;
    uint public totalGames;
    uint public totalPendingGames;

    struct PendingGame {
        uint id;
        address gameCreator;
        uint snakeLength;
        uint value;
        uint timestamp;
    }

    struct Game {
        uint id;
        address opt1;
        uint snakeLength1;
        address opt2;
        uint snakeLength2;
        uint value;
        uint timestamp;
    }


    mapping(uint => PendingGame) public pendingGames;

    mapping(uint => Game) public games;

    mapping(address => uint) public currentGame;

    mapping(address => uint) public claimableRewards;

    mapping(address => uint) public claimedRewards;

    function createGame(uint _snakeLength) external payable {
        require(currentGame[msg.sender] != 0);
        require(msg.value == amount);
        require(_snakeLength >= 0);
        
    }





    constructor(uint _amount) {
        amount = _amount;
        owner = msg.sender;
        totalGames = 0;
        totalPendingGames = 0;
    }
}
