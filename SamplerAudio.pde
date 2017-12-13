//  VOLUME, PITCH, PAN, START, FILTER_TYPE, FILTER_FREQ, FILTER_REZ, BIT_DEPTH, BIT_RATE, DELAY_TIME, DELAY_FEEDBACK 


class SamplerAudio {
  
  Sampler[] samplers = new Sampler[SAMPLES_PER_SAMPLER];
  String[] filenames = new String[SAMPLES_PER_SAMPLER];
  
  Summer summer = new Summer();
  Pan panner = new Pan(0); // pan to center (assumes mono sound---any issues if not? use balance ugen if stereo??)
  MoogFilter filter = new MoogFilter(22050, 0); // default cutoff, rez
  BitCrush crush = new BitCrush(16, 44100);
  Delay delay = new Delay(1.0, 0.0, true, true); //??
  
  // constant ugens to control settings of above ugens
  Constant volume = new Constant(1);
  Constant pitch = new Constant(1); //what value for default pitch???
  Constant panning = new Constant(0);
  //Constant start = new Constant(0);
  //Constant filterType = new Constant(MoogFilter.Type.LP);
  Constant filterFreq = new Constant(22050);
  Constant filterRez = new Constant(0);
  Constant bitDepth = new Constant(16);
  Constant bitRate = new Constant(44100);
  Constant delayTime = new Constant(1);//?
  Constant delayFeedback = new Constant(0);//?
  
  // maybe don't need all these constant ugens?  can directly change some params with some ugen methods 
  
  // temporary constructor for loading defaults
  SamplerAudio(String baseName) {
    
    //println(volume);
    for (int i = 0; i < SAMPLES_PER_SAMPLER; i++) {
      filenames[i] = baseName + (i + 1) + ".wav";
      samplers[i] = new Sampler(filenames[i], 4, minim); //4 is # of voices
      samplers[i].patch(summer); //patch all 4 samples to summer first 
    }
    
    //patching constants
    volume.patch(samplers[0].amplitude);
    volume.patch(samplers[1].amplitude);
    volume.patch(samplers[2].amplitude);
    volume.patch(samplers[3].amplitude);
    
    pitch.patch(samplers[0].rate);
    pitch.patch(samplers[1].rate);
    pitch.patch(samplers[2].rate);
    pitch.patch(samplers[3].rate);
    
    panning.patch(panner.pan);
    filterFreq.patch(filter.frequency);
    filterRez.patch(filter.resonance);
    bitDepth.patch(crush.bitRes);
    bitRate.patch(crush.bitRate);
    delayTime.patch(delay.delTime);
    delayFeedback.patch(delay.delAmp);
    
    //audio path
    filter.setChannelCount(2);
    crush.setChannelCount(2);
    delay.setChannelCount(2);
    
    summer.patch(panner);
    panner.patch(filter);
    filter.patch(crush);
    crush.patch(delay);
    delay.patch(out);
    
  }
  
  
  void load(int sampleIndex, String filename) {
    samplers[sampleIndex] = new Sampler(filename, 4, minim);
    samplers[sampleIndex].patch(summer);
    volume.patch(samplers[sampleIndex].amplitude);
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