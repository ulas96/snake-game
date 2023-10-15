
import './App.css'

function App() {


  

  const board = document.getElementById("board");

  const scoreElement = document.querySelector(".score span");

  const highScoreElement = document.querySelector(".high-score span");

  const gameOverText = document.querySelector(".wrapper-gameover");

let blockSize = 25,
  rows = 25,
  cols = 20,
  context,
  snakeX = blockSize * 5,
  snakeY = blockSize * 5,
  velocityX = 0,
  velocityY = 0,
  snakeBody = [],
  foodX,
  foodY,
  gameOver = false;

board.height = rows * blockSize;
board.width = cols * blockSize;
context = board.getContext("2d");

let highScore = localStorage.getItem("high-score" || 0);
highScoreElement.innerText = highScore;

let positionFood = () => {
  foodX = Math.floor(Math.random() * cols) * blockSize;
  foodY = Math.floor(Math.random() * rows) * blockSize;
};

let drawFood = () => {
  context.fillStyle = "#f10207";
  context.fillRect(foodX, foodY, blockSize, blockSize);
  if (snakeX == foodX && snakeY == foodY) {
    snakeBody.push([foodX, foodY]);
    positionFood();
  }
};

let handelGameOver = () => {
  if (
    snakeX < 0 ||
    snakeX > cols * blockSize ||
    snakeY < 0 ||
    snakeY > rows * blockSize
  ) {
    gameOver = true;
    gameOverText.style = "display: block";
  }

  for (let i = 0; i < snakeBody.length; i++) {
    if (snakeX == snakeBody[i][0] && snakeY == snakeBody[i][1]) {
      gameOver = true;
      gameOverText.style = "display: block";
    }
  }
};

let changeDirection = (e) => {
  switch (e.keyCode) {
    case 37:
      velocityX = -1;
      velocityY = 0;
      break;
    case 38:
      velocityX = 0;
      velocityY = -1;
      break;
    case 39:
      velocityX = 1;
      velocityY = 0;
      break;
    case 40:
      velocityX = 0;
      velocityY = 1;
      break;
  }
};
let updateGame = () => {
  if (gameOver) {
    return;
  }

  context.fillStyle = "#181824";
  context.fillRect(0, 0, board.width, board.height);

  drawFood();

  for (let i = snakeBody.length - 1; i > 0; i--) {
    snakeBody[i] = snakeBody[i - 1];
  }
  if (snakeBody.length) {
    snakeBody[0] = [snakeX, snakeY];
  }

  context.fillStyle = "#56abe7";
  snakeX += velocityX * blockSize;
  snakeY += velocityY * blockSize;
  context.fillRect(snakeX, snakeY, blockSize, blockSize);
  for (let i = 0; i < snakeBody.length; i++) {
    context.fillRect(snakeBody[i][0], snakeBody[i][1], blockSize, blockSize);
  }

  highScore = snakeBody.length >= highScore ? snakeBody.length : highScore;
  localStorage.setItem("high-score", highScore);

  scoreElement.innerText = snakeBody.length;
  handelGameOver();
};

positionFood();

document.addEventListener("keyup", changeDirection);
setInterval(updateGame, 100);

  return (
    <>
      <div className='wrapper-score'>
        <h1 className="score">
            Score
            <span>0</span>
        </h1>

        <h1 className="high-score">
          High Score
            <span>0</span>
        
        </h1>
      </div>

      <canvas id="board"></canvas>

      <div className="wrapper-gameover">
        <h1 className="gameover">Game Ended</h1>
        
      </div>
    </>
  )
}

export default App
