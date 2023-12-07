class Fish {
    float alpha, beta, theta_0, x_w, y_w;
    PVector pos;
    PVector vel = new PVector(0, 0);
    
    boolean isBlue, firstLayer = false;
  
    PImage pink = loadImage("Images/Pink Fish.png");
    PImage blue = loadImage("Images/Blue Fish.png");
    
    Fish(PVector pos, float dx, float dy, float atheta, float btheta) {
      this.pos = pos;
      x_w = random(0, dx);
      y_w = random(0, dy);
      
      int sign1 = int(random(0, 2));
      int sign2 = int(random(0, 2));
      alpha = random(0.4, atheta) * pow(-1, sign1);
      beta = random(0.4, btheta) * pow(-1, sign2);
      theta_0 = random(0, TWO_PI);
      
      isBlue = ( int(random(0, 4)) > 1);
      firstLayer = ( int(random(0, 3)) > 1);
  }
  
  void display() {
    imageMode(CENTER);
    if (isBlue){
      image(blue, pos.x + (x_w * cos((alpha * frameCount / 60) + theta_0)), pos.y + (y_w * sin((beta * frameCount / 60) + theta_0)), 30, 30);
    } else {
      image(pink, pos.x + (x_w * cos((alpha * frameCount / 60) + theta_0)), pos.y + (y_w * sin((beta * frameCount / 60) + theta_0)), 25, 25);
    }
  }
}
