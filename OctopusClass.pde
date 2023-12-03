class Octopus {
  float x, y;
  float speed = 2;
  float radius = 15;
  boolean isRed = false;
  
  PImage orange = loadImage("Images/Enemy/enemy.png");  // Load the green light image
  PImage red = loadImage("Images/Enemy/enemyBoss.png");  // Load the green light image
  
  Octopus() {
    x = width + random(50, 850);
    y = random(height);
    
    if (random(0,2) >= 1){
      isRed = true;
    }
  }
  
  void update() {
    x -= speed;
  }
  
  void display() {
    //fill(255, 165, 0); 
    //ellipse(x, y, 2 * radius, 2 * radius);
    imageMode(CENTER);
    if (isRed){
      image(red, x, y, 100, 100);
    } else {
      image(orange, x, y, 70, 70);
    }
    
  }
  boolean offscreen() {
    return x < -50;
  }
}
