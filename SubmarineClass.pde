class Submarine {
  PVector pos;
  float speed = 5;
  float radius = 20; 
  PVector vel = new PVector(0,0);
  PVector accel = new PVector(0,0);
  PImage[] subSprite = new PImage[11];
  int currentFrame = 0;
  int iterator = 1;
  int numFish = 12;
  
  BoxCollider base_collider, peri_collider;
  Fish[] fishes;
  
  Submarine() {
    pos = new PVector(width/2, height/2);
    
    for (int i = 0; i < subSprite.length; i++){
      String imageName = "Sprites/Player/SpriteImages/subAnimFrames-" + nf(i, 2) + ".png";
      subSprite[i] = loadImage(imageName);
    }
    
    base_collider = new BoxCollider(pos, 55, 55, 0, 35);
    peri_collider = new BoxCollider(pos, 17, 30, 20, 0);
   
    fishes = new Fish[numFish];
    for (int i = 0; i < numFish; i += 1){
      fishes[i] = new Fish(pos, 140, 100, 2, 2);
    }
  }
  
  void update() {
    pos.x = constrain(pos.x, 0, width - radius);
    pos.y = constrain(pos.y, 0, height - radius);
    
    iterator = (iterator + 1) % 2;
    currentFrame = (currentFrame + iterator) % subSprite.length;
  }
  
  void display() {
    // Debug - Collider check
    //rectMode(CORNERS);
    //rect(pos.x - base_collider.l_len, pos.y - base_collider.u_hei, pos.x + base_collider.r_len, pos.y + base_collider.d_hei);
    //rect(pos.x - peri_collider.l_len, pos.y - peri_collider.u_hei, pos.x + peri_collider.r_len, pos.y + peri_collider.d_hei);
    
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
    return ( base_collider.checkCollisionBox(octopus.collider) || peri_collider.checkCollisionBox(octopus.collider) );
  }
}
