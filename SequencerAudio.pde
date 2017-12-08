class SequencerAudio {
  
  int index;
  
  SequencerAudio(int index) {
    this.index = index;
  }
  
  
  void play() {
    if (sequencerGUI[index].getStep()) {
        samplerAudio[index].play(); 
      } 
    
  }
  
}