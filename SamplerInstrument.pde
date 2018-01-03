/*
 class to control which notes trigger and when (kind of intermediary between sequencer and audio)
 */

class SamplerInstrument implements Instrument {
  
  int trackIndex;
  float stepValue;
  
  SamplerInstrument(int trackIndex, float stepValue) {
    this.trackIndex = trackIndex;
    this.stepValue = stepValue;
  }
  
  // each step, this gets a note on command, and plays if step is active  (float dur parameter currently not used, but may need it for diff step values)
  // note: original playnote is called from mastergui from play button
  void noteOn(float dur) {
        
    //for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
      
      if (sequencerGUI[trackIndex].getStep()) {
        samplerAudio[trackIndex].play(sequencerGUI[trackIndex].getCurrentVolume());
      } 
      
    //}
  }
  
  
  // after step (ie after duration is up) it stops if playing is false, otherwise triggers next step (making new instance of this class)
  // (but first determine if next step is affected by the restart/repeat/random settings)
  void noteOff() {
    if (!masterGUI.playing) { return; }
    
    
    
    boolean measureRepeat = masterGUI.repeatMeasure >= random(100);
    boolean beatRepeat = masterGUI.repeatBeat >= random(100);
    boolean stepRepeat = masterGUI.repeatStep >= random(100);
    
    boolean measureRestart = masterGUI.restartOnMeasure >= random(100);
    boolean beatRestart = masterGUI.restartOnBeat >= random(100);
    boolean stepRestart = masterGUI.restartOnStep >= random(100);
    
    boolean measureRandom = masterGUI.randomMeasure >= random(100);
            
    
    
    
      
    //for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
      SequencerGUI currentTrack = sequencerGUI[trackIndex];
      
      boolean onMeasure = (currentTrack.currentStep + 1) % (currentTrack.beatsPerMeasure * currentTrack.stepsPerBeat) == 0;
      boolean onBeat = (currentTrack.currentStep + 1) % (currentTrack.stepsPerBeat) == 0;
      
     //be sure this is the order precedence I want...  
     // 1st does repeats (pretty sure about this one)
     // if no repeats does random, if no random does restart (switch these or no?)
     // if none of above, does normal next step
      
      if (onMeasure && measureRepeat) {
        currentTrack.nextStep(StepType.REPEAT_MEASURE);
      } 
      else if (onBeat && beatRepeat) {
        currentTrack.nextStep(StepType.REPEAT_BEAT);
      } 
      else if (stepRepeat) {
        currentTrack.nextStep(StepType.REPEAT_STEP);
      }     
      
      else if (onMeasure && measureRandom) {
        currentTrack.nextStep(StepType.RANDOM_MEASURE);
      } 
            
      else if ((onMeasure && measureRestart) || (onBeat && beatRestart) || stepRestart) {
         currentTrack.nextStep(StepType.RESTART); // it's restarting at 0
      }      
      
      else {
        currentTrack.nextStep(StepType.STANDARD);   //do normal 'nextstep'  
      }
   // }
    
    
    
    out.setTempo(masterGUI.tempo);
    out.playNote(0, stepValue, this); //play next step immediately , this makes a new instance of itself each step       
  }
  
}