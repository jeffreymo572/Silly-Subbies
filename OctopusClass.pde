class Octopus {
  float x, y;
  float speed = 4;
  float radius = 15;
  boolean isRed = false;
  
  BoxCollider collider;
  
  PImage orange = loadImage("Images/Enemy/enemy.png");  // Load the green light image
  PImage red = loadImage("Images/Enemy/enemyBoss.png");  // Load the green light image
  
  Octopus() {
    x = width + random(50, 850);
    y = random(height);
    
    if (random(0,2) >= 1){
      isRed = true;
      speed -= 2;
    }
    
    if (isRed){
      collider = new BoxCollider(x, y, 30, 30, 20, 15);
    } else {
      collider = new BoxCollider(x, y, 25, 25, 17, 10);
    }
    
  }
  
  void update() {
    x -= speed;
    collider.x = x;
  }
  
  void display() {
    // Debug - Collider check
    rectMode(CORNERS);
    rect(x - collider.l_len, y - collider.u_hei, x + collider.r_len, y + collider.d_hei);
    
    imageMode(CENTER);
    if (isRed){
      image(red, x, y, 100, 100);
    } else {
      image(orange, x, y, 70, 70);
    }
    
  }
  boolean offscreen() {
    return x > width;
  }
}
