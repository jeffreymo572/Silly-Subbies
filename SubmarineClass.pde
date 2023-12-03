class Submarine {
  float x, y;
  float speed = 5;
  float radius = 20; 
  PVector vel = new PVector(0,0);
  PVector accel = new PVector(0,0);;
  PImage[] subSprite = new PImage[11];
  int currentFrame = 0;
  int iterator = 1;
  
  BoxCollider collider;
  ArrayList<Bubble> bubbles;
  
  Submarine() {
    x = width / 2;
    y = height / 2;
    
    for (int i = 0; i < subSprite.length; i++){
      String imageName = "Sprites/Player/SpriteImages/subAnimFrames-" + nf(i, 2) + ".png";
      subSprite[i] = loadImage(imageName);
    }
    
    collider = new BoxCollider(x, y, 55, 55, 20, 35);
  }
  
  void update() {
    x = constrain(x, 0, width - radius);
    y = constrain(y, 0, height - radius);
    
    iterator = (iterator + 1) % 2;
    currentFrame = (currentFrame + iterator) % subSprite.length;
  }
  
  void display() {
    // Debug - Collider check
    rectMode(CORNERS);
    rect(x - collider.l_len, y - collider.u_hei, x + collider.r_len, y + collider.d_hei);
    
    imageMode(CENTER);
    image(subSprite[currentFrame], x, y, 120, 80);    
  }

  void up() {
    vel.y = lerp(vel.y,speed,accel.y);
    y -= vel.y;
    
    collider.y = this.y; 
  }
  void down() {
    vel.y = lerp(vel.y,speed,accel.y);
    y += vel.y;
    
    collider.y = this.y;
  }
  void backward(){
    vel.x = lerp(vel.x,speed,accel.x);
    x -= vel.x;
    
    collider.x = this.x;
  }
  void forward(){
    vel.x = lerp(vel.x,speed,accel.x);
    x += vel.x;
    
    collider.x = this.x;
  }
  
  boolean hits(Octopus octopus) {
    return collider.checkCollisionBox(octopus.collider);
  }
}
