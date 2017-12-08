class SequencerRowGUI {
  
   
  int x, y, index;
  int h = 50;
  int w = width;
  
  Step[] steps = new Step[16];  
  
  
  boolean needsToDraw = true;
  
  
  SequencerRowGUI(int index) {
    this.index = index;
    x = 0;
    y = index * (h + PADDING) + 400;
    
    for (int i = 0; i < 16; i++) {
      steps[i] = new Step(i, y); 
    }
  }
  
  
  void drawGUI() {
    for (int i = 0; i < 16; i++) {
     steps[i].display(); 
    }
    
    needsToDraw = false;
  }
  
  
  void clickCheck(int _mouseX, int _mouseY) {
    for (int i = 0; i < 16; i++) {
      needsToDraw = needsToDraw || steps[i].clickCheck(_mouseX, _mouseY); 
    }
  }
  
  void play() {
    samplerAudio[index].play();
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
    if (!active) {
      fill(100);
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
      stroke(255);
      strokeWeight(2);
    }
    else {
      noStroke();
    }
    
    rect(x, y, STEP_SIZE, STEP_SIZE);
      
      
    
  }
  
  
  boolean clickCheck(int _mouseX, int _mouseY) {
    if (_mouseX >= x && _mouseX <= x + STEP_SIZE && _mouseY >= y && _mouseY <= y + STEP_SIZE && active){
       on = !on;
       return true;
    }
    else {
      return false;
    }
  }
}