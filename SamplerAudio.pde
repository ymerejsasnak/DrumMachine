class SamplerAudio {
  
  Sampler sampler;

  
  SamplerAudio(String defaultFilename) {
    sampler = new Sampler(defaultFilename, 4, minim); //4 is # of voices
    sampler.patch(out); //will probably have to patch through other stuff 1st eventually 
  }
  
  void play() {
    sampler.trigger(); 
  }
  
}