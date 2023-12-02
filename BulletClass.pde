class Bullet {
  float x, y;
  float speed = 10;
  float radius = 5; 
  
  PImage torpedo = loadImage("Images/torpedo.png");
  
  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void update() {
    x += speed;
  }
  
  void display() {
    //fill(255, 0, 0); 
    //ellipse(x, y, 2 * radius, 2 * radius);
    imageMode(CENTER);
    image(torpedo, x, y, 20, 20);
  }
  
  boolean hits(Octopus octopus) {
    float distance = dist(x, y, octopus.x, octopus.y);
    return distance < radius + octopus.radius;
  }
  
  boolean offscreen() {
    return x > width;
  }
}
