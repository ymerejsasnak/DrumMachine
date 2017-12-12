// this is probably superfluous (but wait until implementing more, some of it may make sense to go here)

class SequencerAudio {
  
  int index;
  int stepCounter = 0;
  
  SequencerAudio(int index) {
    this.index = index;
  }
  
  
  void play() {
   
    if (sequencerGUI[index].getStep()) {
        samplerAudio[index].play(); 
    } 
  }
  
}