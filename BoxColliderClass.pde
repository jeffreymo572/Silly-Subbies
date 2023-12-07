class BoxCollider {
  //Box Collider based at the center of the object that it is attached to
  //float x, y;
  PVector pos;
  float r_len, l_len;
  float u_hei, d_hei;
  
  BoxCollider(float x, float y, float len, float hei){
    pos = new PVector(0,0);
    pos.x = x;
    pos.y = y;
    this.r_len = len;
    this.l_len = len;
    this.u_hei = hei;
    this.d_hei = hei;
  }
  
  BoxCollider(PVector pos, float l_len, float r_len, float u_hei, float d_hei){
    this.pos = pos;
    this.r_len = r_len;
    this.l_len = l_len;
    this.u_hei = u_hei;
    this.d_hei = d_hei;
  }
  
  boolean checkCollisionBox(BoxCollider otherCol){
    if ( (otherCol.pos.x - pos.x) >= 0 && (otherCol.pos.y - pos.y) < 0){
      if ( abs(otherCol.pos.x - pos.x) < (otherCol.l_len + this.r_len) && abs(otherCol.pos.y - pos.y) < (otherCol.d_hei + this.u_hei) ){
        return true;
      } else {
        return false;
      }
      
    } else if ( (otherCol.pos.x - pos.x) < 0 && (otherCol.pos.y - pos.y) < 0){
      if ( abs(otherCol.pos.x - pos.x) < (otherCol.r_len + this.l_len) && abs(otherCol.pos.y - pos.y) < (otherCol.d_hei + this.u_hei) ){
        return true;
      } else {
        return false;
      }
      
    } else if ( (otherCol.pos.x - pos.x) >= 0 && (otherCol.pos.y - pos.y) >= 0){
      if ( abs(otherCol.pos.x - pos.x) < (otherCol.l_len + this.r_len) && abs(otherCol.pos.y - pos.y) < (otherCol.u_hei + this.d_hei) ){
        return true;
      } else {
        return false;
      }
      
    } else if ( (otherCol.pos.x - pos.x) < 0 && (otherCol.pos.y - pos.y) >= 0){
      if ( abs(otherCol.pos.x - pos.x) < (otherCol.r_len + this.l_len) && abs(otherCol.pos.y - pos.y) < (otherCol.u_hei + this.d_hei) ){
        return true;
      } else {
        return false;
      }
      
    } else { // This case is technically redundant, as the above four cases get all possible configurations
      return false;
    }
  }
}
