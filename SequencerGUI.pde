class SequencerGUI {
  
   
  int x, y, index;
  int h = 50;
  int w = width;
  
  Step[] steps = new Step[16];  
  
  int currentStep = 0;
  int activeSteps = 16;
  
   
  
  SequencerGUI(int index) {
    this.index = index;
    x = 0;
    y = index * (h + PADDING) + 400;
    
    for (int i = 0; i < 16; i++) {
      steps[i] = new Step(i, y); 
    }
    
    cp5.addButton("addStep" + index)
       .setPosition(width - 200, y)
       .plugTo(this, "addStep")
    
    ;
    cp5.addButton("removeStep" + index)
       .setPosition(width - 100, y)
       .plugTo(this, "removeStep")
    ;
    
  }
  
  
  void drawGUI() {
    for (int i = 0; i < 16; i++) {
     steps[i].display(); 
    }
    
  }
  
  
  void clickCheck(int _mouseX, int _mouseY) {
    for (int i = 0; i < 16; i++) {
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
    if (activeSteps < 16) {
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
    this.x = PADDING + stepIndex * STEP_SIZE + PADDING * stepIndex;
    this.y = y;
  }
  
  
  void display() {
    noStroke();
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
    
    
    rect(x, y, STEP_SIZE, STEP_SIZE);
      
      
    
  }
  
  
  void clickCheck(int _mouseX, int _mouseY) {
    if (_mouseX >= x && _mouseX <= x + STEP_SIZE && _mouseY >= y && _mouseY <= y + STEP_SIZE && active){
       on = !on;
    }
  }
}