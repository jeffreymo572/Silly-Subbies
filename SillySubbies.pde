int gameState = 0; 
Submarine submarine;
ArrayList<Bullet> bullets;
ArrayList<Octopus> octopuses;
int score = 0;
int level = 1;

void setup() {
  size(800, 600);
  submarine = new Submarine();
  bullets = new ArrayList<Bullet>();
  octopuses = new ArrayList<Octopus>();
  spawnOctopuses();
}

void draw() {
  if (gameState == 0) {
    displayHomeScreen();
  } else if (gameState == 1) {
    playGame();
    
    // Check if submarine reached the end
    if (submarine.x >= 850) {
      gameState = 0; // Switch to the home screen
      displayLevelComplete();
    }
  } else if (gameState == 2) {
    gameOver();
  }
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

void spawnOctopuses() {
  int numOctopuses = level * 5;
  for (int i = 0; i < numOctopuses; i++) {
    octopuses.add(new Octopus());
  }
}

void keyPressed() {
  if (keyCode == UP) {
    submarine.up();
  } else if (keyCode == DOWN) {
    submarine.down();
  } else if (key == ' ') {
    bullets.add(new Bullet(submarine.x + 30, submarine.y + 20));
  }
}



void mousePressed() {
  if (gameState == 0) {
    // Check if the start button is clicked
    if (mouseX > 300 && mouseX < 500 && mouseY > 400 && mouseY < 450) {
      gameState = 1; // Switch to game state
      resetGame(); // Initialize or reset game-related variables
    }
    // Check if the controls box is clicked
    else if (mouseX > 300 && mouseX < 500 && mouseY > 500 && mouseY < 550) {
      gameState = 0; // Stay on home screen
      displayControls();
    }
  }
}

void displayHomeScreen() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Submarine Game", width/2, height/3);
  
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

void playGame() {
  background(18, 182, 255);
  
  submarine.update();
  
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.update();
    bullet.display();
    
    // Check for bullet-octopus collisions
    for (int j = octopuses.size() - 1; j >= 0; j--) {
      Octopus octopus = octopuses.get(j);
      if (bullet.hits(octopus)) {
        bullets.remove(i);
        octopuses.remove(j);
        score += 10;
      }
    }
    
    // Remove bullets that go off-screen
    if (bullet.offscreen()) {
      bullets.remove(i);
    }
  }
  
  // Submarine must be drawn over the bullets
  submarine.display();
  
  // Update and display octopuses
  for (Octopus octopus : octopuses) {
    octopus.update();
    octopus.display();
    
    // Check for submarine-octopus collisions
    if (submarine.hits(octopus)) {
      gameState = 2; // Switch to game over state
    }
  }
  
  fill(255);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Level: " + level, 20, 60);
  
  // Check if all octopuses are eliminated
  if (octopuses.size() == 0) {
    // Check if submarine reached the end
    if (submarine.x >= 850) {
      gameState = 3; // Switch to level complete state
    } else {
      level++;
      spawnOctopuses();
    }
  }
}

void gameOver() {
  textSize(32);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/2);
  noLoop();
}

void resetGame() {
  score = 0;
  level = 1;
  submarine = new Submarine();
  bullets.clear();
  octopuses.clear();
  spawnOctopuses();
}
