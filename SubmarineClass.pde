class Submarine {
  PVector pos;
  float speed = 5;
  float radius = 20; 
  PVector vel = new PVector(0,0);
  PVector accel = new PVector(0,0);
  PVector fishCenter = new PVector(0,0);
  PVector fishForce = new PVector(0,0);
  PImage[] subSprite = new PImage[11];
  int currentFrame = 0;
  int iterator = 1;
  int logdamp = -1;
  int numFish = 12;
  
  BoxCollider collider;
  Fish[] fishes;
  
  Submarine() {
    pos = new PVector(width/2, height/2);
    fishCenter = pos.copy();
    
    for (int i = 0; i < subSprite.length; i++){
      String imageName = "Sprites/Player/SpriteImages/subAnimFrames-" + nf(i, 2) + ".png";
      subSprite[i] = loadImage(imageName);
    }
    
    collider = new BoxCollider(pos, 55, 55, 20, 35);
   
    fishes = new Fish[numFish];
    for (int i = 0; i < numFish; i += 1){
      fishes[i] = new Fish(fishCenter, fishForce, 140, 100, 2, 2);
    }
  }
  
  void update() {
    pos.x = constrain(pos.x, 0, width - radius);
    pos.y = constrain(pos.y, 0, height - radius);
    
    fishCenter.x = pos.x;
    fishCenter.y = pos.y;
    
    iterator = (iterator + 1) % 2;
    currentFrame = (currentFrame + iterator) % subSprite.length;
  }
  
  void display() {
    // Debug - Collider check
    //rectMode(CORNERS);
    //rect(pos.x - collider.l_len, pos.y - collider.u_hei, pos.x + collider.r_len, pos.y + collider.d_hei);
    
    imageMode(CENTER);
    image(subSprite[currentFrame], pos.x, pos.y, 120, 80);
  }

  void up() {
    vel.y = lerp(vel.y,speed,accel.y);
    pos.y -= vel.y;
  }
  void down() {
    vel.y = lerp(vel.y,speed,accel.y);
    pos.y += vel.y;
  }
  void backward(){
    vel.x = lerp(vel.x,speed,accel.x);
    pos.x -= vel.x;
  }
  void forward(){
    vel.x = lerp(vel.x,speed,accel.x);
    pos.x += vel.x;    
  }
  
  boolean hits(Octopus octopus) {
<<<<<<< HEAD
    return collider.checkCollisionBox(octopus.collider);
=======
    float distance = dist(x, y, octopus.x, octopus.y);
    return distance < radius + octopus.radius;
>>>>>>> main
  }
}
