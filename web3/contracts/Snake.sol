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
        address winner;
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
        address winner;
        if(_snakeLength == firstPlayersSnakeLength[_id]) {
            claimableRewards[pendingGames[_id].gameCreator] += amount;
            claimableRewards[msg.sender] += amount;
            winner = address(0);
        } else if (_snakeLength <= firstPlayersSnakeLength[_id]) {
            claimableRewards[pendingGames[_id].gameCreator] += (amount * 19) / 10;
            winner = pendingGames[_id].gameCreator;
        } else {
            claimableRewards[msg.sender] += (amount * 19) / 10;
            winner = msg.sender;
        }
        totalGames++;
        games[totalGames] = Game(totalGames, pendingGames[_id].gameCreator, firstPlayersSnakeLength[_id], msg.sender, _snakeLength, pendingGames[_id].value, winner, block.timestamp);
    }


    function claimRewards(uint256 _amount) public {
        require(claimableRewards[msg.sender] > 0);
        require(_amount <= claimableRewards[msg.sender]);
        claimableRewards[msg.sender] -= _amount;
        claimedRewards[msg.sender] += _amount;
        payable(msg.sender).transfer(_amount);
    }

    function cancelGame(uint256 id) external {
        require(msg.sender == pendingGames[id].gameCreator);
        require(pendingGames[id].active == true);
        pendingGames[id].active = false;
        claimableRewards[msg.sender] += amount;
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner);
        payable(msg.sender).transfer(_amount);
    }



    constructor(uint _amount) {
        amount = _amount;
        owner = msg.sender;
        totalGames = 0;
        totalPendingGames = 0;
    }
}
