/* 
class for individual sequencer steps 
*/

class Step {
  
  int x, y;
  int stepIndex;
  
  boolean on = false;
  boolean playing = false;
  
  float stepGain = 0;
  int probability = 100;
  
   
  Step(int stepIndex, int y) {
    this.stepIndex = stepIndex;
    this.x = PADDING * 2 + CLEAR_BUTTON_WIDTH + stepIndex * STEP_WIDTH + stepIndex * STEP_SPACING;
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
    
    // gray out inactive steps (different gray for on and !on)
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
    
    // finally can draw the step
    strokeWeight(2);
    rect(x, y, STEP_WIDTH, STEP_HEIGHT, 25);
        
    // this draws volume bar and probability bar (only for on steps):
    if (on) {
      noStroke();
      fill(0, 0, 100);
      float gdraw = map(stepGain, -10.0, 0.0, 0.0, 1.0);
      rect(x + STEP_WIDTH / 2 - 4, y + STEP_HEIGHT - STEP_HEIGHT * gdraw, 4, STEP_HEIGHT * gdraw);
      fill(0, 100, 150);
      float pdraw = map(probability, 0, 100, 0, 1);
      rect(x + STEP_WIDTH / 2, y + STEP_HEIGHT - STEP_HEIGHT * pdraw, 4, STEP_HEIGHT * pdraw);
    }
  }
  
  
  void clickCheck(int _mouseX, int _mouseY, int _mouseButton, int sequencerIndex) {
    if (_mouseX >= x && _mouseX <= x + STEP_WIDTH && _mouseY >= y && _mouseY <= y + STEP_HEIGHT){
      // left button: step on - left half of step does volume, right half does probability (based on y)
      // right button: step off
      // middle button: last active step
      
      if (_mouseButton == LEFT) {
        on = true;
        if (_mouseX <= x + STEP_WIDTH / 2) {
          stepGain = map(_mouseY, y + STEP_HEIGHT, y, -10.0, 0);
        }
        else {
          probability = int(map(_mouseY, y + STEP_HEIGHT, y, 0, 100));
        }
      }
        
      else if (_mouseButton == RIGHT) {
        on = false;
      }
            
      else if (_mouseButton == CENTER) {
        sequencerGUI[sequencerIndex].activeSteps = stepIndex + 1;
        
      }
    }
  }
  
}