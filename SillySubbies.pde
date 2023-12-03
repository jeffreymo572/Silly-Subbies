int gameState = 0;
Submarine submarine;
ArrayList<Bullet> bullets;
ArrayList<Octopus> octopuses;
int score = 0;
int level = 1;
String[] highscore;
GUI Gui;
boolean paused;

import processing.sound.*;
SoundFile menu, fire, hit, death, win, zohit;
SoundBoard soundBoard;

PImage background;

// player inputs to control submarine: {up,down,left,right,shoot}
boolean[] inputs = {false, false, false, false, false};

void setup() {

    size(800, 600);
    submarine = new Submarine();
    bullets = new ArrayList<Bullet>();
    octopuses = new ArrayList<Octopus>();
    highscore = loadStrings("highscore.txt");
    spawnOctopuses();
    Gui = new GUI(highscore);
    paused = false;
    
    //Background Image
    background = loadImage("Images/Water Background.png");
    
    // Sounds
    menu = new SoundFile(this, "Sound/menuSong.wav");
    fire = new SoundFile(this, "Sound/Fire.wav");
    hit = new SoundFile(this, "Sound/TorpedoHit.wav");
    death = new SoundFile(this, "Sound/playerDeath.wav");
    win = new SoundFile(this, "Sound/Win.wav");
    zohit = new SoundFile(this, "Sound/zohit.wav");
    soundBoard = new SoundBoard(menu, fire, hit, death, win, zohit);
    
}

void draw() {
  if (gameState == 0) {
    Gui.displayHomeScreen();
    soundBoard.loopMenu();
  }
  // Game start
  else if (gameState == 1) {
    if (!(paused)){
      playGame();
      soundBoard.stopMenu();
      soundBoard.loopZohit();
    }
    else{
      Gui.displayPaused();
    }

    // Check if submarine reached the end
    if (submarine.x >= 850) {
        gameState = 0; // Switch to the home screen
        Gui.displayLevelComplete();
    }
  }
  
   else if (gameState == 2) {
    Gui.gameOver();
    soundBoard.stopZohit();
    soundBoard.playDeath();
    }
   if (gameState == 4){
      Gui.displayControls();
   }
}

void spawnOctopuses() {
    if (random(1) >0.3){
     octopuses.add(new Octopus());   
    }
    //int numOctopuses = level * 5;
    //for (int i = 0; i < numOctopuses; i++) {
    //    octopuses.add(new Octopus());
    //}
}

void move() {
    // move up
    if (inputs[0]) {
        submarine.accel.y = 0.1;
        submarine.up();
    }
    // move down
    if (inputs[1]) {
        submarine.accel.y = 0.1;
        submarine.down();
    }
    // move backward
    if (inputs[2]) {
        submarine.accel.x = 0.1;
        submarine.backward();
    }
    //move right
    if (inputs[3]) {
        submarine.accel.x = 0.015;
        submarine.forward();
    }
    //shoot
    if (inputs[4]) {
        bullets.add(new Bullet(submarine.x, submarine.y));
        inputs[4] = !inputs[4];
    }
}

void keyPressed() {
    if (key == 'w') {
      inputs[0] = true;
    }
    if (key == 's') {
      inputs[1] = true;
    }
    if (key == 'a') {
      inputs[2] = true;
    }
    if (key == 'd') {
      inputs[3] = true;
    }
    if (key == ' ') {
      inputs[4] = true;
    }
    
    if (key == 'p'){
      paused = !paused;
    }
}

void keyReleased() {
    if (key == 'w') {
        inputs[0] = false;
        submarine.accel.y = 0;
        submarine.vel.y = 0;
    }
    if (key == 's') {
        inputs[1] = false;
        submarine.accel.y = 0;
        submarine.vel.y = 0;
    }
    if (key == 'a' ) {
        inputs[2] = false;
        submarine.accel.x = 0;
        submarine.vel.x = 0;
    }
    if (key == 'd') {
        inputs[3] = false;
        submarine.accel.x = 0;
        submarine.vel.x = 0;
    }
    if (key == ' ') {
        inputs[4] = false;
        soundBoard.playFire();
    }
}
void mousePressed() {
    // Main menu
    if (gameState == 0) {
      // Check if the start button is clicked
      if (mouseX > 300 && mouseX < 500 && mouseY > 400 && mouseY < 450) {
        gameState = 1; // Switch to game state
        resetGame(); // Initialize or reset game-related variables
      }
      // Check if the controls box is clicked
      else if (mouseX > 300 && mouseX < 500 && mouseY > 500 && mouseY < 550) {
        gameState = 4; // Stay on home screen
        Gui.displayControls();
      }
    }
    
    // Paused
    else if (gameState == 1){
      if (paused){
        println("Paused");
        if (mouseX > 20 && mouseX < 120 && mouseY < 60 && mouseY > 20){
          paused = !paused;
          playGame();
        }
      }
    }
    
    // Death
    else if (gameState == 2){
      if (mouseX > 300 && mouseX < 500 && mouseY > 400 && mouseY < 450){
        gameState = 1;
        resetGame();
      }
    }
    
    // Controls menu
    else if (gameState == 4){
      if (mouseX > 20 && mouseX < 120 && mouseY < 60 && mouseY > 20){
        gameState = 0;
        Gui.displayHomeScreen();
      }
    }
}

void playGame() {
    //background(200);
    //Background scroll functionality
    backgroundScroll(background);
    
    
    move();
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
                soundBoard.playHit();
                score += 10;
            }
        }
        // Remove bullets that go off-screen
        if (bullet.offscreen()) {
            bullets.remove(i);
        }
    }
    
    //Display Submarine after bullets
    submarine.display();
    // Update and display octopuses
    ArrayList<Octopus> octopusesCopy = new ArrayList<Octopus>();
    for (Octopus octopus : octopuses) {
        if (!octopus.offscreen()){ 
         octopusesCopy.add(octopus);
        } 
        octopus.update();
        octopus.display();

        // Check for submarine-octopus collisions
        if (submarine.hits(octopus)) {
            gameState = 2; // Switch to game over state
        }
    }
    octopuses = octopusesCopy;
    Gui.displayScore();
    
    // Check if all octopuses are eliminated
    if (octopuses.size() <= 15) {
        spawnOctopuses();
    }
    //    // Check if submarine reached the end
    //    if (submarine.x >= 850) {
    //        gameState = 3; // Switch to level complete state
    //    } else {
    //        level++;
    //        spawnOctopuses();
    //    }
    //}
    
}


void resetGame() {
    score = 0;
    level = 1;
    submarine = new Submarine();
    bullets.clear();
    octopuses.clear();
    spawnOctopuses();
}

void backgroundScroll(PImage img){
  int x_right = frameCount % img.width;
  copy(img, x_right, 0, img.width, height, 0, 0, img.width, height);
  
  int x_remain = img.width - x_right;
  if (x_remain < width) {
    copy(img, 0, 0, img.width, height, x_remain, 0, img.width, height);
  }
}
