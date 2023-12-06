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
      text("Silly Subbies", width/2, height/3);
      text("Highscore: " + highscore[0], width/2, height/3 +50);
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
    text("Press WASD for up, left, down, and right.", width/2, height/2 - 30);
    text("Press SPACEBAR to shoot bullets and eliminate octopuses.", width/2, height/2 + 30);
    text("Press P to paused", width/2, height/2 + 90);

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
      text("Game Over", width/2, height/2-60);
      if (score > int(highscore[0])){
          highscore[0] = str(score);
          saveStrings("highscore.txt", highscore);
      }
      
      // Play again button
      fill(0, 0, 150);
      rect(300, 400, 200, 50);
      fill(255);
      textSize(20);
      text("Play Again", width/2, 425);
  }
  
  void displayScore(){
    fill(255);
    textSize(20);
    textAlign(LEFT, CENTER);
    text("Score: " + score, 30, 30);
    text("Current High Score: " + highscore[0], 30, 60);
    // Check if all octopuses are eliminated
    if (octopuses.size() <= 5) {
        // Check if submarine reached the end
        if (submarine.x >= 850) {
            gameState = 3; // Switch to level complete state
        } else {
            spawnOctopuses();
        }
    }
  }
  
  void displayPaused(){
    background(100);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Paused", width/2, height/3);
    
    // Paused Text
    text("Press P to unpause or click resume", width/2, height/2+30);
    
    // Resume button
    fill(255, 0, 0);
    rect(20, 20, 100, 40);
    fill(255);
    textSize(16);
    text("Resume", 70, 40); 
  }
}
