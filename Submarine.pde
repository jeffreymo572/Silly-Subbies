class Submarine {
  float x, y;
  float speed = 15;
  float radius = 20; 
  PImage submarineImage;
  
  Submarine() {
    x = width / 2;
    y = height / 2;
  }
  
  void update() {
    x = constrain(x, 0, width - radius);
    y = constrain(y, 0, height - radius);
  }
  
  void display() {
    fill(0, 0, 255); 
    ellipse(x, y, 2 * radius, 2 * radius);
  }
  
  void up() {
    y -= speed;
  }
  
  void down() {
    y += speed;
  }
  
  boolean hits(Octopus octopus) {
    float distance = dist(x, y, octopus.x, octopus.y);
    return distance < radius + octopus.radius;
  }
}
