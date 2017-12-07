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