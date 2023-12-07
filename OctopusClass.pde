class Octopus {
  PVector pos;
  float speed = 4;
  boolean isRed = false;
  
  BoxCollider collider;
  
  PImage orange = loadImage("Images/Enemy/enemy.png");
  PImage red = loadImage("Images/Enemy/enemyBoss.png");
  
  Octopus() {
    float x = width + random(50, 850);
    float y = random(height);
    
    pos = new PVector(x, y);
    
    if (random(0,2) >= 1){
      isRed = true;
      speed -= 2;
    }
    
    if (isRed){
      collider = new BoxCollider(pos, 30, 30, 20, 15);
    } else {
      collider = new BoxCollider(pos, 25, 25, 17, 10);
    }
    
  }
  
  void update() {
    pos.x -= speed;
  }
  
  void display() {
<<<<<<< Updated upstream
=======
    // Debug - Collider check
    rectMode(CORNERS);
    rect(pos.x - collider.l_len, pos.y - collider.u_hei, pos.x + collider.r_len, pos.y + collider.d_hei);
    
>>>>>>> Stashed changes
    imageMode(CENTER);
    if (isRed){
      image(red, pos.x, pos.y, 100, 100);
    } else {
      image(orange, pos.x, pos.y, 70, 70);
    }
    
  }
  boolean offscreen() {
    return pos.x < -50;
  }
}
