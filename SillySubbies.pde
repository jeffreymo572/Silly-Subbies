int gameState = 0;
Submarine submarine;
ArrayList<Bullet> bullets;
ArrayList<Octopus> octopuses;
int score = 0;
int level = 1;
String[] highscore;
GUI Gui;
boolean paused;


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
}

void draw() {
  if (gameState == 0) {
    Gui.displayHomeScreen();
  } else if (gameState == 1) {
    if (!(paused)){
      playGame();
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
    }
   if (gameState == 4){
      Gui.displayControls();
   }
}

void spawnOctopuses() {
    int numOctopuses = level * 5;
    for (int i = 0; i < numOctopuses; i++) {
        octopuses.add(new Octopus());
    }
}

void move() {
    // move up
    if (inputs[0]) {
        submarine.accel.y = 0.1;
        submarine.up();
    }
    if (inputs[1]) {
        submarine.accel.y = 0.1;
        submarine.down();
    }
    if (inputs[2]) {
        submarine.accel.x = 0.1;
        submarine.backward();
    }
    if (inputs[3]) {
        submarine.accel.x = 0.1;
        submarine.forward();
    }
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
        gameState = 4; // Stay on home screen
        Gui.displayControls();
      }
    }
    
    else if (gameState == 1){
      if (paused){
        println("Paused");
        if (mouseX > 20 && mouseX < 120 && mouseY < 60 && mouseY > 20){
          paused = !paused;
          playGame();
        }
      }
    }
    
    else if (gameState == 2){
      
    }
    
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
    for (Octopus octopus : octopuses) {
        octopus.update();
        octopus.display();

        // Check for submarine-octopus collisions
        if (submarine.hits(octopus)) {
            gameState = 2; // Switch to game over state
        }
    }
    Gui.displayScore();

    fill(255);
    textSize(20);

    text("Score: " + score, 50, 30);
    text("Level: " + level, 50, 60);

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

