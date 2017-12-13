class SequencerGUI {
  
   
  int x, y, index;
  int h = SEQUENCER_TRACK_HEIGHT;
  int w = width;
  
  Step[] steps = new Step[MAX_STEPS];  
  
  int currentStep = 0;
  int activeSteps = MAX_STEPS;
  int[] stepCounters = new int[12];
  
  
  SequencerGUI(int index) {
    this.index = index;
    x = 0;
    y = index * (h + PADDING) + SEQUENCER_VERTICAL_OFFSET;
    
    for (int i = 0; i < MAX_STEPS; i++) {
      steps[i] = new Step(i, y); 
    }    
  }
  
  
  void drawGUI() {
    for (int i = 0; i < MAX_STEPS; i++) {
     steps[i].display(activeSteps); 
    }
    
  }
  
  
  void clickCheck(int _mouseX, int _mouseY, int _mouseButton) {
    for (int i = 0; i < MAX_STEPS; i++) {
      steps[i].clickCheck(_mouseX, _mouseY, _mouseButton, index); 
    }
  }
  
  
  boolean getStep() {
    steps[currentStep].playing = true;
    return steps[currentStep].on;  
  }
  
  
  void nextStep() {
    for (int i = 0; i < 11; i++) {
      stepCounters[i]++;
      
      if (stepCounters[i] >= cp5.getController("stepschange" + index + i).getValue()) {
        stepCounters[i] = 0; 
        Setting setting = Setting.values()[i];
        
        
        float value = random(settingsGUI[index].rangeSettings[i].getLowValue(),
                             settingsGUI[index].rangeSettings[i].getHighValue());
        
        switch (setting) {
          
          case VOLUME:
            samplerAudio[index].volume.setConstant(value); 
            break;
          case PITCH:
            samplerAudio[index].pitch.setConstant(value);
            break;
          case PAN:
            samplerAudio[index].panning.setConstant(value);
            break;
            
            
          case FILTER_FREQ:
            samplerAudio[index].filterFreq.setConstant(value);
            break;
          case FILTER_REZ:
            samplerAudio[index].filterRez.setConstant(value);
            break;
            
          case BIT_DEPTH:
            samplerAudio[index].bitDepth.setConstant(value);
            break;
          case BIT_RATE:
            samplerAudio[index].bitRate.setConstant(value);
            break;
            
          case DELAY_TIME:
            samplerAudio[index].delayTime.setConstant(value);
            println(samplerAudio[index].delay.delTime.getLastValue());
            break;
          case DELAY_FEEDBACK:
            samplerAudio[index].delayFeedback.setConstant(value);
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