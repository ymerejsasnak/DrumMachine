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
  Summer sumUgen = new Summer();
  Pan panUgen = new Pan(0); // pan to center (assumes mono sound---any issues if not? use balance ugen if stereo??)
  MoogFilter filterUgen = new MoogFilter(22050, 0); // default cutoff, rez
  BitCrush crushUgen = new BitCrush(16, 44100);
  Delay delayUgen = new Delay(1.0, 0.0, true, true); //??
  
  // constant ugens to control settings of above ugens (numbers are default values...need constants)
  Constant volume = new Constant(1);
  Constant pitch = new Constant(1);
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
  
  
  SamplerAudio(int trackIndex) {
    
    this.trackIndex = trackIndex;
    // this part is temporary...loads default wavs in an easy way...
    //for (int samplerIndex = 0; samplerIndex < SAMPLES_PER_SAMPLEGROUP; samplerIndex++) {
    //  filenames[samplerIndex] = baseName + (samplerIndex + 1) + ".wav";
    //  samplers[samplerIndex] = new Sampler(filenames[samplerIndex], SAMPLER_VOICES, minim); //4 is # of voices
    //  samplers[samplerIndex].patch(sumUgen); //patch all 4 samples to summer first 
    //}
    
    //patching constants
    //for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLEGROUP; sampleIndex++) {
    //  volume.patch(samplers[sampleIndex].amplitude);
    //  pitch.patch(samplers[sampleIndex].rate);
    //}
    
    panning.patch(panUgen.pan);
    
    bitDepth.patch(crushUgen.bitRes);
    bitRate.patch(crushUgen.bitRate);
    
    filterFreq.patch(filterUgen.frequency);
    filterRez.patch(filterUgen.resonance);
    
    delayTime.patch(delayUgen.delTime);
    delayFeedback.patch(delayUgen.delAmp);
    
    // output from pan is stereo so set subsequent ugens to be stereo too
    filterUgen.setChannelCount(2);
    crushUgen.setChannelCount(2);
    delayUgen.setChannelCount(2);
    
    // patch audio path
    sumUgen.patch(panUgen);
    panUgen.patch(crushUgen);
    crushUgen.patch(filterUgen);
    filterUgen.patch(delayUgen);
    delayUgen.patch(out);
    
  }
  
  
  // load file into sampler (from load button on sampler gui)
  void load(int sampleIndex, String filename) {
    samplers[sampleIndex] = new Sampler(filename, SAMPLER_VOICES, minim);
    samplers[sampleIndex].patch(sumUgen);
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
    
    while(!validIndexes.contains(indexToTrigger)) {
      indexToTrigger = (indexToTrigger + 1) % SAMPLES_PER_SAMPLEGROUP;
    }
    
    
    new Constant(volume).patch(samplers[indexToTrigger].amplitude);
    samplers[indexToTrigger].trigger();
    lastPlayedIndex = indexToTrigger;
  }
  
}