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
    
    cp5.addButton("addStep" + index)
       .setCaptionLabel("+")
       .setSize(STEP_BUTTON_WIDTH, STEP_BUTTON_HEIGHT)
       .setPosition((STEP_WIDTH + PADDING) * MAX_STEPS + PADDING + STEP_BUTTON_WIDTH, y)
       .plugTo(this, "addStep")
       .moveTo("Sequencer")
    
    ;
    cp5.addButton("removeStep" + index)
       .setCaptionLabel("-")
       .setSize(STEP_BUTTON_WIDTH, STEP_BUTTON_HEIGHT)
       .setPosition((STEP_WIDTH + PADDING) * MAX_STEPS + PADDING, y)
       .plugTo(this, "removeStep")
       .moveTo("Sequencer")
    ;
    
  }
  
  
  void drawGUI() {
    for (int i = 0; i < MAX_STEPS; i++) {
     steps[i].display(); 
    }
    
  }
  
  
  void clickCheck(int _mouseX, int _mouseY) {
    if (!sequencerTab.isActive()) {
      return;
    }
    for (int i = 0; i < activeSteps; i++) {
      steps[i].clickCheck(_mouseX, _mouseY); 
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
  
  
  void addStep() {
    if (activeSteps < MAX_STEPS) {
      activeSteps += 1;
      steps[activeSteps-1].active = true;
    }
  }
  
  void removeStep() {
    if (activeSteps > 1) {
      activeSteps -= 1;
      steps[activeSteps].active = false;
    }
  }
  
}



class Step {
  
  int x, y;
  int stepIndex;
  
  boolean on = false;
  boolean active = true;
  boolean playing = false;
  
  Step(int stepIndex, int y) {
    this.stepIndex = stepIndex;
    this.x = PADDING + stepIndex * STEP_WIDTH + PADDING * stepIndex;
    this.y = y;
  }
  
  
  void display() {
    if (stepIndex % 4 == 0) {
      stroke(100);
    }
    else {
      noStroke();
    }
    
    if (!active) {
      fill(60);
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
    
    
    rect(x, y, STEP_WIDTH, STEP_HEIGHT);
      
      
    
  }
  
  
  void clickCheck(int _mouseX, int _mouseY) {
    if (_mouseX >= x && _mouseX <= x + STEP_WIDTH && _mouseY >= y && _mouseY <= y + STEP_HEIGHT){
       on = !on;
    }
  }
}