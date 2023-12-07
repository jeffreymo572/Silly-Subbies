class Bullet {
  //float x, y;
  PVector pos;
  float speed = 10;
  float radius = 5; 
  
  BoxCollider collider;
  
  PImage torpedo = loadImage("Images/torpedo.png");
  
  Bullet(float x, float y) {
    pos = new PVector(x, y);
    
    collider = new BoxCollider(pos, 12.5, 8, 7.5, 6);
  }
  
  void update() {
    pos.x += speed;
  }
  
  void display() {
    // Debug - Collider check
    //rectMode(CORNERS);
    //rect(pos.x - collider.l_len, pos.y - collider.u_hei, pos.x + collider.r_len, pos.y + collider.d_hei);
    
    imageMode(CENTER);
    image(torpedo, pos.x, pos.y, 25, 15); //x and y offsets for the submarine
  }
  
  boolean hits(Octopus octopus) {
    return collider.checkCollisionBox(octopus.collider);
  }
  
  boolean offscreen() {
    return pos.x > width;
  }
}
