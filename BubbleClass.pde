class Bubble {
  float x, y;
  float speed = 15;
  float radius = 20; 
  
  PImage[] bubSprite = new PImage[9];
  int currentFrame = 0;
  int iterator = 1;
  
  Bubble() {
    x = width / 2;
    y = height / 2;
    
    for (int i = 0; i < bubSprite.length; i++){
      String imageName = "Sprites/Bubbles/pixil-frame-0-" + nf(i, 1) + ".png";
      bubSprite[i] = loadImage(imageName);
    }
  }
  
  Bubble(int x, int y) {
    this.x = x;
    this.y = y;
    
    for (int i = 0; i < bubSprite.length; i++){
      String imageName = "Sprites/Bubbles/pixil-frame-0-" + nf(i, 1) + ".png";
      bubSprite[i] = loadImage(imageName);
    }
  }
  
  void update() {
    x -= speed;
    x = constrain(x, 0, width - radius);
    y = constrain(y, 0, height - radius);
    
    //iterator = (iterator + 1) % 2;
    currentFrame = (currentFrame + 1) % bubSprite.length;
  }
  
  void display() {
    imageMode(CENTER);
    image(bubSprite[currentFrame], x, y, 20, 20);
  }
  
}
