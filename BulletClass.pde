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
    imageMode(CENTER);
    image(torpedo, pos.x, pos.y, 25, 15);
  }
  
  boolean hits(Octopus octopus) {
    return collider.checkCollisionBox(octopus.collider);
  }
  
  boolean offscreen() {
    return pos.x > width;
  }
}
