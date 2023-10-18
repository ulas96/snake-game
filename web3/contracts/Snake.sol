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
        uint value;
        uint timestamp;
        bool active;
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


    mapping(uint => uint) public firstPlayersSnakeLength;

    mapping(uint => PendingGame) public pendingGames;

    mapping(uint => Game) public games;

    //mapping(address => uint) public currentGame; //existence: questionable

    mapping(address => uint) public claimableRewards;

    mapping(address => uint) public claimedRewards;

    function createGame(uint _snakeLength) external payable {
        //require(currentGame[msg.sender] != 0);
        require(msg.value >= amount);
        require(_snakeLength >= 0);
        totalPendingGames++;
        pendingGames[totalPendingGames] = PendingGame(totalPendingGames, msg.sender, msg.value, block.timestamp, true);
        firstPlayersSnakeLength[totalPendingGames] = _snakeLength;
    }

    function joinGame(uint _id, uint _snakeLength) external payable {
        require(pendingGames[_id].active == true);
        require(msg.value >= amount);
        require(_snakeLength >= 0);
        totalGames++;
        games[totalGames] = Game(totalGames, pendingGames[_id].gameCreator, firstPlayersSnakeLength[_id], msg.sender, _snakeLength, amount, block.timestamp);
    }





    constructor(uint _amount) {
        amount = _amount;
        owner = msg.sender;
        totalGames = 0;
        totalPendingGames = 0;
    }
}
