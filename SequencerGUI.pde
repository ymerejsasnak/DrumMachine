class SequencerGUI {
  
   
  int x, y, index;
  int h = SEQUENCER_TRACK_HEIGHT;
  int w = width;
  
  Step[] steps = new Step[MAX_STEPS];  
  
  int currentStep = 0;
  int activeSteps = MAX_STEPS;
  
  
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