class Octopus {
  float x, y;
  float speed = 2;
  float radius = 15; 
  
  Octopus() {
    x = width + random(50, 850);
    y = random(height); 
  }
  
  void update() {
    x -= speed;
  }
  
  void display() {
    fill(255, 165, 0); 
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}
