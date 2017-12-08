// IDM: Idiosyncratic Drum Machine

/* TO DO:
save file path from loading file so selection dialog goes back to last folder used


*/

import controlP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;


Minim minim;
AudioOutput out;

ControlP5 cp5;


SamplerAudio[] samplerAudio = new SamplerAudio[4];
SamplerListener[] samplerListener = new SamplerListener[4];
SamplerGUI[] samplerGUI = new SamplerGUI[4];

SequencerRowGUI[] sequencerRowGUI = new SequencerRowGUI[4];





void setup() {
  size(1000, 800);
  background(BG_COLOR);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  cp5 = new ControlP5(this);
  
  samplerAudio[0] = new SamplerAudio("BD.wav");
  samplerAudio[1] = new SamplerAudio("SN1.wav");
  samplerAudio[2] = new SamplerAudio("SN2.wav");
  samplerAudio[3] = new SamplerAudio("CHH.wav");
  for (int i = 0; i < 4; i++) {
    samplerListener[i] = new SamplerListener(i); //give it the index
    samplerGUI[i] = new SamplerGUI(i);
    
    sequencerRowGUI[i] = new SequencerRowGUI(i);
  }
 
  frameRate(60); // higher framerate = more precise beat timing
  
}


void draw() {
  println(frameRate);
  
  for (int i = 0; i < 4; i++) {
    if (samplerGUI[i].needsToDraw) {
      samplerGUI[i].drawGUI();
    }
    if (sequencerRowGUI[i].needsToDraw) {
      sequencerRowGUI[i].drawGUI();
    }
  }
  
  
  
}



void mousePressed() {
  for(int i = 0; i < 4; i++) {
    sequencerRowGUI[i].clickCheck(mouseX, mouseY); 
  }
}