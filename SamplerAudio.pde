/*
  Controls the loading, routing, and actual triggering of audio samples 
  (with help from SamplerInstrument class below it)
*/

class SamplerAudio {
  
  Sampler[] samplers = new Sampler[SAMPLES_PER_SAMPLEGROUP];
  String[] filenames = new String[SAMPLES_PER_SAMPLEGROUP];
  
  RandomType randomType = RandomType.RANDOM;
  int lastPlayedIndex = -1;
  
  int trackIndex;
  
  //ugens to route audio through
  Summer samplerSummerUgen = new Summer();
  Gain settingsGainUgen = new Gain();
  Gain sequenceGainUgen = new Gain();
  
  //Multiplier gainMultiplier = new Multiplier();
  Pan panUgen = new Pan(0); // pan to center (assumes mono sound---any issues if not? use balance ugen if stereo??)
  MoogFilter filterUgen = new MoogFilter(22050, 0); // default cutoff, rez
  BitCrush crushUgen = new BitCrush(16, 44100);
  Delay delayUgen = new Delay(1.0, 0.0, true, true); //??
  
   
  
  SamplerAudio(int trackIndex) {
    
    this.trackIndex = trackIndex;
        
    // output from pan is stereo so set subsequent ugens to be stereo too
    filterUgen.setChannelCount(2);
    crushUgen.setChannelCount(2);
    delayUgen.setChannelCount(2);
    
    // patch audio path
    samplerSummerUgen.patch(sequenceGainUgen)
                     .patch(settingsGainUgen)
                     
                     .patch(panUgen)
                     .patch(crushUgen)
                     .patch(filterUgen)
                     .patch(delayUgen)
                     .patch(out);
    
    
  }
  
  
  // load file into sampler (from load button on sampler gui)
  void load(int sampleIndex, String filename) {
    samplers[sampleIndex] = new Sampler(filename, SAMPLER_VOICES, minim);
    samplers[sampleIndex].patch(samplerSummerUgen);
    //volume.patch(samplers[sampleIndex].amplitude);
  }
  
  
  // play method called from sequencer...this will trigger the actual audio
  void play(float volume) { 
    
    //first need list of valid indexes (some samples may not be loaded)  -- should be sep method
    //then must randomly choose from those
    
    ArrayList<Integer> validIndexes = new ArrayList<Integer>();
    
    for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLEGROUP; sampleIndex++) {
      if (samplers[sampleIndex] != null){
        validIndexes.add(sampleIndex);
      }
      
    }
    
    // exit if NO samples loaded
    if (validIndexes.size() == 0) {
      return;
    }
    
    int choice = int(random(validIndexes.size()));
    
    int indexToTrigger = validIndexes.get(choice);//int(random(0, SAMPLES_PER_SAMPLEGROUP));
    switch (randomType) {
      case RANDOM:
        //do nothing, pure random
        break;
      case AVOID_PREVIOUS:
        //if same sample was played last time, incremement index by 1 (mod to cycle to 0)
        if (indexToTrigger == lastPlayedIndex) {
          indexToTrigger = (indexToTrigger + 1) % SAMPLES_PER_SAMPLEGROUP;
        }
        break;
      case CYCLE:
        // cycle just increments sample index, no randomness
        indexToTrigger = (lastPlayedIndex + 1) % SAMPLES_PER_SAMPLEGROUP;
        break;     
    }
    
    // skip over empty sample slots
    while(!validIndexes.contains(indexToTrigger)) {
      indexToTrigger = (indexToTrigger + 1) % SAMPLES_PER_SAMPLEGROUP;
    }
    
    
    new Constant(volume).patch(sequenceGainUgen.gain);
    samplers[indexToTrigger].trigger();
    lastPlayedIndex = indexToTrigger;
  }
  
  
  // method to change settings using a line so no sudden clicks in purer sounds
  void patchLine(UGen.UGenInput input, float newValue) { 
    Line line = new Line(0.1, input.getLastValues()[0], newValue);
    line.patch(input);
    line.setLineTime(0.1);
    line.activate();
  }
  
}