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
  
  
  SequencerGUI(int trackIndex) {
    this.trackIndex = trackIndex;
    x = 0;
    y = trackIndex * (h + PADDING) + SEQUENCER_VERTICAL_OFFSET;
    
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
      steps[stepIndex] = new Step(stepIndex, y); 
    }    
  }
  
  
  void drawGUI() {
    for (int stepIndex = 0; stepIndex < MAX_STEPS; stepIndex++) {
     steps[stepIndex].display(activeSteps); 
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
    for (int i = 0; i < 11; i++) {
      stepCounters[i]++;
      
      if (stepCounters[i] >= cp5.getController("stepschange" + trackIndex + i).getValue()) {
        stepCounters[i] = 0; 
        Setting setting = Setting.values()[i];
        
        
        float value = random(settingsGUI[trackIndex].rangeSettings[i].getLowValue(),
                             settingsGUI[trackIndex].rangeSettings[i].getHighValue());
        
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
  
  
  void display(int activeSteps) {
    if (stepIndex % 16 == 0) {
      stroke(120, 120, 250);
    }
    else if (stepIndex % 4 == 0) {
      stroke(80, 80, 170); 
    }
    else {
      noStroke();
    }
    
    if (stepIndex > activeSteps - 1) {
      if (on) {
        fill(100);
      }
      else {
        fill(60);
      }
    }
    else {
      if (on) {
        fill(100, 100, 200);
      }
      else {
        fill(50, 50, 150);
      }
    }
    
    if (playing) {
      fill(150, 150, 150);
    }  
    
    strokeWeight(2);
    rect(x, y, STEP_WIDTH, STEP_HEIGHT);
        
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