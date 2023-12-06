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
    imageMode(CENTER);
    image(torpedo, x + 50, y + 30, 25, 15); //x and y offsets for the submarine
  }
  
  boolean hits(Octopus octopus) {
    float distance = dist(x, y, octopus.x, octopus.y);
    return distance < radius + octopus.radius;
  }
  
  boolean offscreen() {
    return x > width;
  }
}
