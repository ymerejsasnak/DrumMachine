// IDM: Idiosyncratic Drum Machine

import controlP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;


Minim minim;
AudioOutput out;

ControlP5 cp5;



SamplerListener[] samplerListener = new SamplerListener[4];
SamplerGUI[] samplerGUI = new SamplerGUI[4];
SamplerAudio[] samplerAudio = new SamplerAudio[4];



void setup() {
  size(1000, 800);
  background(50);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  cp5 = new ControlP5(this);
  
  for (int i = 0; i < 4; i++) {
    samplerListener[i] = new SamplerListener(i + 1); //give it the index
    samplerGUI[i] = new SamplerGUI(i * 200 + 20, 20, i + 1);
  }
  samplerAudio[0] = new SamplerAudio("BD.wav");
  samplerAudio[1] = new SamplerAudio("SNR.wav");
  samplerAudio[2] = new SamplerAudio("CHH.wav");
  samplerAudio[3] = new SamplerAudio("OHH.wav");
    
  
}


void draw() {
  for (int i = 0; i < 4; i++) {
    samplerGUI[i].display();
  }
}