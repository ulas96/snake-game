
import './App.css'

function App() {

  const board = document.querySelector("#board");
  const score = document.querySelector(".score span")

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
        <h1 className="gameover">Game Over</h1>
        <button className="restart">Restart</button>
      </div>
    </>
  )
}

export default App
