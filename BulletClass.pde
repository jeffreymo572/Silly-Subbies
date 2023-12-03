class Bullet {
  float x, y;
  float speed = 10;
  float radius = 5; 
  
  BoxCollider collider;
  
  PImage torpedo = loadImage("Images/torpedo.png");
  
  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    
    collider = new BoxCollider(x, y, 12.5, 8, 7.5, 6);
  }
  
  void update() {
    x += speed;
    collider.x = this.x;
  }
  
  void display() {
    // Debug - Collider check
    //rectMode(CORNERS);
    //rect(x - collider.l_len, y - collider.u_hei, x + collider.r_len, y + collider.d_hei);
    
    imageMode(CENTER);
    image(torpedo, x, y, 25, 15); //x and y offsets for the submarine
  }
  
  boolean hits(Octopus octopus) {
    return collider.checkCollisionBox(octopus.collider);
  }
  
  boolean offscreen() {
    return x > width;
  }
}
