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
  int[] stepCounters = new int[12]; //total # of settings that need to count steps
  
  int stepsPerBeat = DEFAULT_STEPS_PER_BEAT;    // for now just pass these along to step class
  int beatsPerMeasure = DEFAULT_BEATS_PER_MEASURE;
  
  int triggerOn = 100;
  int triggerOff = 0; // values from 0 to 100 (ie percent) to determine probability of triggering on and off steps  
  
  
  
  SequencerGUI(int trackIndex) {
    this.trackIndex = trackIndex;
    x = 0;
    y = trackIndex * (h + PADDING) * 2 + PADDING * 2;
    
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
      steps[stepIndex] = new Step(stepIndex, y); 
    }    
    
    
    cp5.addSlider("stepsPerBeat" + trackIndex)
       .setCaptionLabel("")
       .setPosition(x + PADDING, y + STEP_HEIGHT + PADDING)
       .setSize(SLIDER_WIDTH, 20)
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
       .setPosition(x + SLIDER_WIDTH + PADDING * 2, y + STEP_HEIGHT + PADDING)
       .setSize(SLIDER_WIDTH, 20)
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
    
   
    cp5.addSlider("%triggeroff" + trackIndex)
       .setPosition(width - 400, y +  STEP_HEIGHT + PADDING)
       .setWidth(200)
       .setValue(0)
       .plugTo(this, "setTriggerOff")
       .moveTo("Sequencer")
       ;
       
    cp5.addSlider("%triggeron" + trackIndex)
       .setPosition(width - 200, y + STEP_HEIGHT + PADDING)
       .setWidth(200)
       .setValue(100)
       .plugTo(this, "setTriggerOn")
       .moveTo("Sequencer")
       ;
       
    cp5.addButton("clear" + trackIndex)
       .setPosition(width/2, y + STEP_HEIGHT + PADDING)
       
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


  void setTriggerOff(int percent) {
     triggerOff = percent;
  }
  
  void setTriggerOn(int percent) {
    triggerOn = percent; 
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
  
  
  void clickCheck(int _mouseX, int _mouseY, int _mouseButton) {
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
      steps[stepIndex].clickCheck(_mouseX, _mouseY, _mouseButton, trackIndex); 
    }
  }
  
  
  boolean getStep() {
    steps[currentStep].playing = true;
    return steps[currentStep].on;  
  }
  
  
  void nextStep() {
    for (int settingsIndex = 0; settingsIndex < Setting.values().length; settingsIndex++) {
      stepCounters[settingsIndex]++;
      
      if (stepCounters[settingsIndex] >= cp5.getController("stepschange" + trackIndex + settingsIndex).getValue()) {
        stepCounters[settingsIndex] = 0; 
        Setting setting = Setting.values()[settingsIndex];
        
        
        float value = random(settingsGUI[trackIndex].rangeSettings[settingsIndex].getLowValue(),
                             settingsGUI[trackIndex].rangeSettings[settingsIndex].getHighValue());
        
        switch (setting) {
          
          case VOLUME:
            samplerAudio[trackIndex].volume.setConstant(value); 
            break;
          case PITCH:
            samplerAudio[trackIndex].pitch.setConstant(value);
            break;
          case PAN:
            samplerAudio[trackIndex].panning.setConstant(value);
            break;
            
            
          case FILTER_FREQ:
            samplerAudio[trackIndex].filterFreq.setConstant(value);
            break;
          case FILTER_REZ:
            samplerAudio[trackIndex].filterRez.setConstant(value);
            break;
            
          case BIT_DEPTH:
            samplerAudio[trackIndex].bitDepth.setConstant(value);
            break;
          case BIT_RATE:
            samplerAudio[trackIndex].bitRate.setConstant(value);
            break;
            
          case DELAY_TIME:
            samplerAudio[trackIndex].delayTime.setConstant(value);
            
            break;
          case DELAY_FEEDBACK:
            samplerAudio[trackIndex].delayFeedback.setConstant(value);
            break;
            
        }
      }
    
    }
    steps[currentStep].playing = false;
    currentStep = (currentStep + 1) % activeSteps;  
  }
  
}


class Step {
  
  int x, y;
  int stepIndex;
  
  boolean on = false;
  boolean playing = false;
  
   
  Step(int stepIndex, int y) {
    this.stepIndex = stepIndex;
    this.x = PADDING + stepIndex * STEP_WIDTH + STEP_SPACING * stepIndex;
    this.y = y;
  }
  
  
  void display(int activeSteps, int stepsPerBeat, int beatsPerMeasure) {
    // highlight start of each 'measure'
    if (stepIndex % (stepsPerBeat * beatsPerMeasure) == 0) {
      stroke(120, 120, 250);
    }
    // highlight start of each beat
    else if (stepIndex % stepsPerBeat == 0) {
      stroke(80, 80, 170); 
    }
    // no highlight for other steps
    else {
      noStroke();
    }
    
    // gray out inactive steps
    if (stepIndex > activeSteps - 1) {
      if (on) {
        fill(100);
      }
      else {
        fill(60);
      }
    }
    
    // active steps are blue-ish
    else {
      if (on) {
        fill(100, 100, 200);
      }
      else {
        fill(50, 50, 150);
      }
    }
    
    // light gray to highlight playing step
    if (playing) {
      fill(150, 150, 150);
    }  
    
    strokeWeight(2);
    rect(x, y, STEP_WIDTH, STEP_HEIGHT, 25);
        
  }
  
  
  void clickCheck(int _mouseX, int _mouseY, int _mouseButton, int sequencerIndex) {
    if (_mouseX >= x && _mouseX <= x + STEP_WIDTH && _mouseY >= y && _mouseY <= y + STEP_HEIGHT){
      if (_mouseButton == LEFT) {
        on = !on;
      }
      else if (_mouseButton == RIGHT) {
        sequencerGUI[sequencerIndex].activeSteps = stepIndex + 1;
      }
    }
  }
  
}