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


SamplerAudio[] samplerAudio = new SamplerAudio[8];
SamplerListener[] samplerListener = new SamplerListener[8];
SamplerGUI[] samplerGUI = new SamplerGUI[8];

SequencerAudio[] sequencerAudio = new SequencerAudio[8];
SequencerGUI[] sequencerGUI = new SequencerGUI[8];

MasterGUI masterGUI;

Tab sequencerTab, samplerTab;



void setup() {
  size(1200, 800);
  background(BG_COLOR);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  
  cp5 = new ControlP5(this);
  
  samplerAudio[0] = new SamplerAudio("BD.wav");
  samplerAudio[1] = new SamplerAudio("SN1.wav");
  samplerAudio[2] = new SamplerAudio("SN2.wav");
  samplerAudio[3] = new SamplerAudio("CHH.wav");
  samplerAudio[4] = new SamplerAudio("BD.wav");
  samplerAudio[5] = new SamplerAudio("SN1.wav");
  samplerAudio[6] = new SamplerAudio("SN2.wav");
  samplerAudio[7] = new SamplerAudio("CHH.wav");
  
  for (int i = 0; i < TOTAL_TRACKS; i++) {
    samplerListener[i] = new SamplerListener(i); //give it the index
    samplerGUI[i] = new SamplerGUI(i);
    
    sequencerAudio[i] = new SequencerAudio(i);
    sequencerGUI[i] = new SequencerGUI(i);
  }
  masterGUI = new MasterGUI();
 
 
  cp5.getTab("default").hide(); 
   
  sequencerTab = cp5.addTab("Sequencer").setActive(true);
  ;
  samplerTab = cp5.addTab("Samples")
  ;
  
  cp5.getWindow().setPositionOfTabs(0, height - 20);
  
}


void draw() {
  background(BG_COLOR);
  
  for (int i = 0; i < TOTAL_TRACKS; i++) {
    if (samplerTab.isActive()) {
      samplerGUI[i].drawGUI();
    }
    if (sequencerTab.isActive()) {
      sequencerGUI[i].drawGUI();
    }
  }

 
  
}



void mousePressed() {
  for(int i = 0; i < TOTAL_TRACKS; i++) {
    sequencerGUI[i].clickCheck(mouseX, mouseY); 
  }
}