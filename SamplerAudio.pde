class SamplerAudio {
  
  Sampler sampler;
  String filename;
  float[] sampleData;

  
  SamplerAudio(String newFilename) {
    this.filename = newFilename;
    sampler = new Sampler(filename, 4, minim); //4 is # of voices
    sampler.patch(out); //will probably have to patch through other stuff 1st eventually 
  
    
  }
  
  void play() {
    sampler.trigger(); 
  }
  
  String getFilename() {
    //ugly way to extract  filename from full path/file name....butonly linux w/ the '/'?
    return filename.substring(filename.lastIndexOf("/") + 1);
  } 

}


class SampleInstrument implements Instrument {
  
  void noteOn(float dur) {
    for (int i = 0; i < 4; i++) {
      if (sequencerGUI[i].getStep()) { samplerAudio[i].play(); } 
    }
    
  }
  
  void noteOff() {
    if (!masterGUI.playing) { return; }
    for (int i = 0; i < 4; i++) {
      sequencerGUI[i].nextStep(); 
    }
    out.setTempo(masterGUI.tempo);
    out.playNote(0, 0.25f, this); //play next note immediately (dur 16th)    
    
  }
  
}