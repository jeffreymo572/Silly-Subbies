class Bubbles {
  Bubble[] bubbles;
  
  Bubbles(int size, float x, float y_bot, float y_top){
    bubbles = new Bubble[size];
    
    for (int i = 0; i < bubbles.length; i++){
      int y = int(random(y_bot, y_top));
      bubbles[i] = new Bubble(int(x), y);
    }
  }
  
  void update(){
    for (int i = 0; i < bubbles.length; i++){
      bubbles[i].update();
    }
  }
  
}
