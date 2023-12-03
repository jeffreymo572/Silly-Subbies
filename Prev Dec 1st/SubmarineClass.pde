class Submarine {
  float x, y;
  float speed = 15;
  float radius = 20; 
  
  PImage[] subSprite = new PImage[11];
  int currentFrame = 0;
  int iterator = 1;
  
  Bubbles bubbles;
  
  Submarine() {
    x = width / 2;
    y = height / 2;
    
    for (int i = 0; i < subSprite.length; i++){
      String imageName = "Sprites/Player/SpriteImages/subAnimFrames-" + nf(i, 2) + ".png";
      subSprite[i] = loadImage(imageName);
    }
  }
  
  void update() {
    x = constrain(x, 0, width - radius);
    y = constrain(y, 0, height - radius);
    
    iterator = (iterator + 1) % 2;
    currentFrame = (currentFrame + iterator) % subSprite.length;
    
    bubbles = new Bubbles(x - 60, y + 80, y - 80);
    bubbles.update();
  }
  
  void display() {
    //fill(0, 0, 255); 
    //ellipse(x, y, 2 * radius, 2 * radius);
    imageMode(CENTER);
    image(subSprite[currentFrame], x, y, 120, 80);
    
    bubbles.display();
  }
  
  void up() {
    y -= speed;
  }
  
  void down() {
    y += speed;
  }
  
  boolean hits(Octopus octopus) {
    // Needs work
    float distance = dist(x, y, octopus.x, octopus.y);
    return distance < radius + octopus.radius;
  }
}
