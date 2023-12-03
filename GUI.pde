class GUI{
  String[] highscore;
  boolean displayControlBool;
  
  GUI(String[] highScore){
    highscore = highScore;
  }
  
  void displayHomeScreen() {
      background(0);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(32);
      text("Submarine Game", width/2, height/3);
      text("highscore: " + highscore[0], width/2, height/3 +50);
      // Start button
      fill(0, 255, 0);
      rect(300, 400, 200, 50);
      fill(255);
      textSize(20);
      text("Start Game", width/2, 425);
  
      // Controls box
      fill(0, 0, 255);
      rect(300, 500, 200, 50);
      fill(255);
      text("Controls", width/2, 525);
  }
  
  void displayControls() {
    // Display controls information on the home screen
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Controls", width/2, height/4);
    textSize(18);
    text("Use UP and DOWN arrow keys to move the submarine.", width/2, height/2 - 30);
    text("Press SPACEBAR to shoot bullets and eliminate octopuses.", width/2, height/2 + 30);

    // Back button
    fill(255, 0, 0);
    rect(20, 20, 100, 40);
    fill(255);
    textSize(16);
    text("Back", 70, 40);
  }
  
  void displayLevelComplete() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Level " + level + " Complete", width/2, height/3);

    // Go home button
    fill(0, 255, 0);
    rect(300, 400, 200, 50);
    fill(255);
    textSize(20);
    text("Go Home", width/2, 425);

    // Next level button
    fill(0, 0, 255);
    rect(300, 500, 200, 50);
    fill(255);
    text("Play Next Level", width/2, 525);
  }

  void gameOver() {
      textSize(32);
      fill(255, 0, 0);
      textAlign(CENTER, CENTER);
      text("Game Over", width/2, height/2);
      if (score > int(highscore[0])){
          highscore[0] = str(score);
          saveStrings("highscore.txt", highscore);
      }
      
      noLoop();
  }
  
  void displayScore(){
    fill(255);
    textSize(20);
    text("Score: " + score, 60, 30);
    text("Level: " + level, 60, 60);
    // Check if all octopuses are eliminated
    if (octopuses.size() <= 5) {
        // Check if submarine reached the end
        if (submarine.x >= 850) {
            gameState = 3; // Switch to level complete state
        } else {
            level++;
            spawnOctopuses();
        }
    }
  }
}