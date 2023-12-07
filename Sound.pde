import processing.sound.*;

class SoundBoard{
  SoundFile menu, fire, hit, death, win, zohit;
  boolean deathPlayed = false;

  SoundBoard(SoundFile menu, SoundFile fire, SoundFile hit, SoundFile death, SoundFile win, SoundFile zohit){
    this.menu = menu;
    this.fire = fire;
    this.hit = hit;
    this.death = death;
    this.win = win;
    this.zohit = zohit;
  }
  
  boolean isMenuPlaying(){
    return this.menu.isPlaying();
  }
  
  boolean isZohitPlaying(){
    return this.zohit.isPlaying();
  }

  // Menu Music
  void loopMenu(){
    if (!this.menu.isPlaying()){
      this.menu.play();
    }
  }
  
  void pauseMenu(){
    this.menu.pause();
  }
  
  void stopMenu(){
    if (this.menu.isPlaying()){
      this.menu.stop();
    }
  }

  void loopZohit(){
    if (!this.zohit.isPlaying()){
      this.zohit.play();
    }
  }
  
  void pauseZohit(){
    this.zohit.pause();
  }

  void stopZohit(){
    if (this.zohit.isPlaying()){
      this.zohit.stop();
    }
  }

  void playFire(){
    this.fire.play();
  }

  void playHit(){
    this.hit.play();
  }

  void playDeath(){
    if (!this.death.isPlaying()){
      this.death.play();
      deathPlayed = true;
    }
  }
  void stopDeath(){
    if (this.death.isPlaying()){
      this.death.stop();
    }
  }

  void playWin(){
    if (!this.win.isPlaying()){
      this.win.play();
    }
  }
}
