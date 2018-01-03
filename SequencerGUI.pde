/*
  Defines/displays the sequencer tab GUI components (steps and related controls)
  (uses step class below for individual steps in the sequencer)
*/

class SequencerGUI { //rename/refactor?  this is actually gui for individual track
  
   
  int x, y, trackIndex;
  int h = SEQUENCER_TRACK_HEIGHT;
  int w = width;
  
  Step[] steps = new Step[MAX_STEPS];  
  
  int currentStep = 0;
  int activeSteps = MAX_STEPS;
  int[] stepCounters = new int[Setting.values().length]; //total # of settings that need to count steps
  
  int stepsPerBeat = DEFAULT_STEPS_PER_BEAT;    // for now just pass these along to step class
  int beatsPerMeasure = DEFAULT_BEATS_PER_MEASURE;
  
    
  SequencerGUI(int trackIndex) {
    this.trackIndex = trackIndex;
    x = 0;
    y = trackIndex * (h + PADDING * 2) + PADDING * 2;
    
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
      steps[stepIndex] = new Step(stepIndex, y); 
    }    
    
    cp5.addSlider("stepsPerBeat" + trackIndex)
       .setCaptionLabel("")
       .setPosition(SEQUENCER_TRACK_WIDTH + CLEAR_BUTTON_WIDTH + PADDING * 3, y + STEP_HEIGHT / 2)
       .setSize(SLIDER_WIDTH, SLIDER_HEIGHT)
       .setRange(MIN_STEPS_PER_BEAT, MAX_STEPS_PER_BEAT)
       .setNumberOfTickMarks(MAX_STEPS_PER_BEAT - MIN_STEPS_PER_BEAT + 1)
       .showTickMarks(false)
       .setSliderMode(Slider.FLEXIBLE)
       .setValue(4) 
       .plugTo(this, "setStepsPerBeat")
       .moveTo("Sequencer")
    ;
    cp5.addSlider("beatsPerMeasure" + trackIndex) 
       .setCaptionLabel("")
       .setPosition(SEQUENCER_TRACK_WIDTH + CLEAR_BUTTON_WIDTH + PADDING * 3, y)
       .setSize(SLIDER_WIDTH, SLIDER_HEIGHT)
       .setRange(MIN_BEATS_PER_MEASURE, MAX_BEATS_PER_MEASURE)
       .setNumberOfTickMarks(MAX_STEPS_PER_BEAT - MIN_STEPS_PER_BEAT + 1)
       .showTickMarks(false)
       .setSliderMode(Slider.FLEXIBLE)
       .setValue(4)
       .plugTo(this, "setBeatsPerMeasure")
       .moveTo("Sequencer")
    ;
    
    //cp5.add
    //step value
       
    cp5.addButton("clear" + trackIndex)
       .setCaptionLabel("X")
       .setPosition(PADDING, y + PADDING)
       
       .setWidth(CLEAR_BUTTON_WIDTH)
       .plugTo(this, "clearTrack")
       .moveTo("Sequencer")
       ;
  }

  
  void setStepsPerBeat(int stepsNumber) {
    stepsPerBeat = stepsNumber;
  }
  
  
  void setBeatsPerMeasure(int beatsNumber) {
    beatsPerMeasure = beatsNumber;
  }


  void clearTrack() {
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
      steps[stepIndex].on = false; 
    }
  }
  
  
  void drawGUI() {
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
     steps[stepIndex].display(activeSteps, stepsPerBeat, beatsPerMeasure); 
    }
    
  }
  
  
  // runs through all steps
  void clickCheck(int _mouseX, int _mouseY, int _mouseButton) {
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
      steps[stepIndex].clickCheck(_mouseX, _mouseY, _mouseButton, trackIndex); 
    }
  }
  
  
  boolean getStep() {
    steps[currentStep].playing = true;
    boolean triggerIt = steps[currentStep].on && steps[currentStep].probability >= random(100);
    return triggerIt;  
  }
  
  
  // this should probably be split up into various things
  // currently it increments counters for settings randomization, then sets a new value for any setting whose counter is up,
  // then sets current to not playing, then increments beat based on steptype...yikes
  // 1 idea: instead of steptype sent to this method, just make seperate methods based on step type and call them specifically from inst noteoff
  void nextStep(StepType stepType) {
    for (int settingsIndex = 0; settingsIndex < Setting.values().length; settingsIndex++) {
      stepCounters[settingsIndex]++;
      
      if (stepCounters[settingsIndex] >= cp5.getController("stepschange" + trackIndex + settingsIndex).getValue()) {
        stepCounters[settingsIndex] = 0; 
        Setting setting = Setting.values()[settingsIndex];
        
        
        float value = random(settingsGUI[trackIndex].rangeSettings[settingsIndex].getLowValue(),
                             settingsGUI[trackIndex].rangeSettings[settingsIndex].getHighValue());
        
        SamplerAudio currentAudio = samplerAudio[trackIndex];
        
        switch (setting) {
          case PITCH:
            for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLEGROUP; sampleIndex++) {
              if (currentAudio.samplers[sampleIndex] != null) {
                currentAudio.patchLine(currentAudio.samplers[sampleIndex].rate, value); 
              }
            }
            break;
            
          case START:
            for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLEGROUP; sampleIndex++) {
              if (currentAudio.samplers[sampleIndex] != null) {
                float sampleLength = currentAudio.samplers[sampleIndex].end.getLastValues()[0];
                value = map(value, 0, 100, 0, sampleLength);
                currentAudio.patchLine(currentAudio.samplers[sampleIndex].begin, value); 
              }
            }
            break;
          
          case GAIN:
            currentAudio.patchLine(currentAudio.settingsGainUgen.gain, value);
            
            break;
          case PAN:
            currentAudio.patchLine(currentAudio.panUgen.pan, value);
            break;
            
            
          case FILTER_FREQ:
            currentAudio.patchLine(currentAudio.filterUgen.frequency, value);
            break;
          case FILTER_REZ:
            currentAudio.patchLine(currentAudio.filterUgen.resonance, value);
            break;
            
          case BIT_DEPTH:
            currentAudio.patchLine(currentAudio.crushUgen.bitRes, value);
            break;
          case BIT_RATE:
            currentAudio.patchLine(currentAudio.crushUgen.bitRate, value);
            break;
            
          case DELAY_TIME:
            currentAudio.patchLine(currentAudio.delayUgen.delTime, value);            
            break;
          case DELAY_FEEDBACK:
            currentAudio.patchLine(currentAudio.delayUgen.delAmp, value);
            break;
            
        }
      }
    
    }
    
    steps[currentStep].playing = false;
    
        
    switch (stepType) {
      case STANDARD:
        currentStep = (currentStep + 1) % activeSteps;
        break;
        
      case RESTART:
        currentStep = 0;
        break;
        
      case REPEAT_MEASURE:
        currentStep -= stepsPerBeat * beatsPerMeasure - 1;
        break;
      case REPEAT_BEAT:
        currentStep -= stepsPerBeat - 1;
        break; 
      case REPEAT_STEP:
        // no need to do anything here
        break;
        
      case RANDOM_MEASURE:
        currentStep = int(random(activeSteps) / (stepsPerBeat * beatsPerMeasure)) * stepsPerBeat * beatsPerMeasure;
        break;
    }
     if (currentStep < 0) {
          currentStep = activeSteps - currentStep; 
     }
    
  }
  
  float getCurrentVolume() {
    return steps[currentStep].stepGain;
  }
  
}