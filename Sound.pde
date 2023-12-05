import processing.sound.*;

class SoundBoard{
  SoundFile menu, fire, hit, death, win, zohit;

  SoundBoard(SoundFile menu, SoundFile fire, SoundFile hit, SoundFile death, SoundFile win, SoundFile zohit){
    this.menu = menu;
    this.fire = fire;
    this.hit = hit;
    this.death = death;
    this.win = win;
    this.zohit = zohit;
  }

  // Menu Music
  void loopMenu(){
    if (!this.menu.isPlaying()){
      this.menu.play();
    }
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
