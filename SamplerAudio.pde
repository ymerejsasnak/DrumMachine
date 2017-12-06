class SamplerAudio {
  
  Sampler sampler;
  String filename;

  
  SamplerAudio(String newFilename) {
    this.filename = newFilename;
    sampler = new Sampler(filename, 4, minim); //4 is # of voices
    sampler.patch(out); //will probably have to patch through other stuff 1st eventually 
  
    
  }
  
  void play() {
    sampler.trigger(); 
  }
  

}