// IDM: Idiosyncratic Drum Machine

import controlP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

Sampler sample1;  // will have 3 or 4 at least eventually (maybe even more?!?!?)



void setup() {
  size(800, 600);
  background(50);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  sample1 = new Sampler("1.wav", 4, minim); //4 is # of voices
  
  sample1.patch(out); //will probably have to patch through other stuff 1st eventually
}


void draw() {
  
}

void mousePressed() {
  sample1.trigger(); 
}