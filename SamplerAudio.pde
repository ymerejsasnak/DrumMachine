/*
  Controls the loading, routing, and actual triggering of audio samples 
  (with help from SamplerInstrument class below it)
*/

class SamplerAudio {
  
  Sampler[] samplers = new Sampler[SAMPLES_PER_SAMPLEGROUP];
  String[] filenames = new String[SAMPLES_PER_SAMPLEGROUP];
  
  RandomType randomType = RandomType.RANDOM;
  int lastPlayedIndex = -1;
  
  Summer sumUgen = new Summer();
  Pan panUgen = new Pan(0); // pan to center (assumes mono sound---any issues if not? use balance ugen if stereo??)
  MoogFilter filterUgen = new MoogFilter(22050, 0); // default cutoff, rez
  BitCrush crushUgen = new BitCrush(16, 44100);
  Delay delayUgen = new Delay(1.0, 0.0, true, true); //??
  
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
    for (int samplerIndex = 0; samplerIndex < SAMPLES_PER_SAMPLEGROUP; samplerIndex++) {
      filenames[samplerIndex] = baseName + (samplerIndex + 1) + ".wav";
      samplers[samplerIndex] = new Sampler(filenames[samplerIndex], SAMPLER_VOICES, minim); //4 is # of voices
      samplers[samplerIndex].patch(sumUgen); //patch all 4 samples to summer first 
    }
    
    //patching constants
    for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLEGROUP; sampleIndex++) {
      volume.patch(samplers[sampleIndex].amplitude);
      pitch.patch(samplers[sampleIndex].rate);
    }
    
    panning.patch(panUgen.pan);
    filterFreq.patch(filterUgen.frequency);
    filterRez.patch(filterUgen.resonance);
    bitDepth.patch(crushUgen.bitRes);
    bitRate.patch(crushUgen.bitRate);
    delayTime.patch(delayUgen.delTime);
    delayFeedback.patch(delayUgen.delAmp);
    
    //audio path
    filterUgen.setChannelCount(2);
    crushUgen.setChannelCount(2);
    delayUgen.setChannelCount(2);
    
    sumUgen.patch(panUgen);
    panUgen.patch(filterUgen);
    filterUgen.patch(crushUgen);
    crushUgen.patch(delayUgen);
    delayUgen.patch(out);
    
  }
  
  
  void load(int sampleIndex, String filename) {
    samplers[sampleIndex] = new Sampler(filename, SAMPLER_VOICES, minim);
    samplers[sampleIndex].patch(sumUgen);
    volume.patch(samplers[sampleIndex].amplitude);
  }
  
  
  void play() { 
    int indexToTrigger = int(random(0, SAMPLES_PER_SAMPLEGROUP));
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
    samplers[indexToTrigger].trigger();
    lastPlayedIndex = indexToTrigger;
  }
  
}


class SampleInstrument implements Instrument {
  
  void noteOn(float dur) {
    for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
      if (sequencerGUI[trackIndex].getStep()) { samplerAudio[trackIndex].play(); } 
    }
  }
  
  
  void noteOff() {
    if (!masterGUI.playing) { return; }
    for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
      sequencerGUI[trackIndex].nextStep(); 
    }
    out.setTempo(masterGUI.tempo);
    out.playNote(0, QUARTER_NOTE, this); //play next note immediately (dur 16th)       
  }
  
}