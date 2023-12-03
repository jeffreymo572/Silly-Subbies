class Bubbles {
  Bubble[] bubbles;
  
  Bubbles(float x, float y_bot, float y_top){
    bubbles = new Bubble[8];
    
    for (int i = 0; i < bubbles.length; i++){
      float y = random(y_bot, y_top);
      bubbles[i] = new Bubble(x, y);
    }
  }
  
  void update(){
    bubbles[0].update();
    bubbles[1].update();
    bubbles[2].update();
    bubbles[3].update();
    bubbles[4].update();
    bubbles[5].update();
    bubbles[6].update();
    bubbles[7].update();
  }
  
  void display(){
    bubbles[0].display();
    bubbles[1].display();
    bubbles[2].display();
    bubbles[3].display();
    bubbles[4].display();
    bubbles[5].display();
    bubbles[6].display();
    bubbles[7].display();
  }
  
}
