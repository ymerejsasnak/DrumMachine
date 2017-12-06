// IDM: Idiosyncratic Drum Machine

import controlP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;


Minim minim;
AudioOutput out;

ControlP5 cp5;


SamplerAudio[] samplerAudio = new SamplerAudio[4];
SamplerListener[] samplerListener = new SamplerListener[4];
SamplerGUI[] samplerGUI = new SamplerGUI[4];




void setup() {
  size(1000, 800);
  background(50);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  cp5 = new ControlP5(this);
  
  samplerAudio[0] = new SamplerAudio("BD.wav");
  samplerAudio[1] = new SamplerAudio("SNR.wav");
  samplerAudio[2] = new SamplerAudio("CHH.wav");
  samplerAudio[3] = new SamplerAudio("OHH.wav");
  for (int i = 0; i < 4; i++) {
    samplerListener[i] = new SamplerListener(i); //give it the index
    samplerGUI[i] = new SamplerGUI(i * 200 + 20, 20, i);
  }
 
    
  
}


void draw() {
  if (frameCount == 1) {
    for (int i = 0; i < 4; i++) {
      samplerGUI[i].redrawSampler();
    }
  }
}