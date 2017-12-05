// IDM: Idiosyncratic Drum Machine

import controlP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

Sampler sample1;  // will have 3 or 4 at least eventually (maybe even more?!?!?)

SampleWindow window1, window2;

ControlP5 cp5;


void setup() {
  size(960, 600);
  background(50);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  sample1 = new Sampler("1.wav", 4, minim); //4 is # of voices
  
  sample1.patch(out); //will probably have to patch through other stuff 1st eventually
  
  
  
  cp5 = new ControlP5(this);
  
  window1 = new SampleWindow(20, 20, 1);
  window2 = new SampleWindow(275, 20, 2);
}


void draw() {
  window1.display();
  window2.display();
}

void mousePressed() {
  sample1.trigger(); 
}