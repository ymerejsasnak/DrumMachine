class SamplerAudio {
  
  Sampler[] samplers = new Sampler[SAMPLES_PER_SAMPLER];
  String[] filenames = new String[SAMPLES_PER_SAMPLER];

  // temporary constructor for loading defaults
  SamplerAudio(String baseName) {
    for (int i = 0; i < SAMPLES_PER_SAMPLER; i++) {
      filenames[i] = baseName + (i + 1) + ".wav";
      samplers[i] = new Sampler(filenames[i], 4, minim); //4 is # of voices
      samplers[i].patch(out); //will probably have to patch through other stuff 1st eventually 
    }
  }
  
  
  void load(int sampleIndex, String filename) {
    samplers[sampleIndex] = new Sampler(filename, 4, minim);
    samplers[sampleIndex].patch(out);
  }
  
  
  void play() { //(split this into 3 diff methods, called based on selection in sampler group
    // TEMP - pure random trigger of four loaded samples 
    samplers[int(random(0, SAMPLES_PER_SAMPLER))].trigger(); 
  }
  
}


class SampleInstrument implements Instrument {
  
  void noteOn(float dur) {
    for (int i = 0; i < TOTAL_TRACKS; i++) {
      if (sequencerGUI[i].getStep()) { samplerAudio[i].play(); } 
    }
  }
  
  
  void noteOff() {
    if (!masterGUI.playing) { return; }
    for (int i = 0; i < TOTAL_TRACKS; i++) {
      sequencerGUI[i].nextStep(); 
    }
    out.setTempo(masterGUI.tempo);
    out.playNote(0, 0.25f, this); //play next note immediately (dur 16th)       
  }
  
}