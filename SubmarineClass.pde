class Submarine {
  float x, y;
  float speed = 15;
  float radius = 20; 
  PVector vel = new PVector(0,0);
  PVector accel = new PVector(0,0);;
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
  }
  
  void display() {
    //fill(0, 0, 255); 
    //ellipse(x, y, 2 * radius, 2 * radius);
    imageMode(CENTER);
    image(subSprite[currentFrame], x, y, 120, 80);
    
    //bubbles = new Bubbles(5, x - 60, y + 40, y - 40);
    //bubbles.update();
  }

  void up() {
    vel.y = lerp(vel.y,speed,accel.y);
    y -= vel.y;
  }
  void down() {
      vel.y = lerp(vel.y,speed,accel.y);
    y += vel.y;
  }
  void backward(){
      vel.x = lerp(vel.x,speed,accel.x);
   x -= vel.x;   
  }
  void forward(){
   vel.x = lerp(vel.x,speed,accel.x);
   x += vel.x;   
  }
  
  boolean hits(Octopus octopus) {
    // Needs work
    float distance = dist(x, y, octopus.x, octopus.y);
    return distance < radius + octopus.radius;
  }
}
