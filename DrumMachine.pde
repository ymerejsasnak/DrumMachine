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
//SamplerListener[] samplerListener = new SamplerListener[8];
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
  
  // hardcoded default loading for now
  samplerAudio[0] = new SamplerAudio("kick");
  samplerAudio[1] = new SamplerAudio("snareA");
  samplerAudio[2] = new SamplerAudio("snareB");
  samplerAudio[3] = new SamplerAudio("hihat");
  samplerAudio[4] = new SamplerAudio("bongo");
  samplerAudio[5] = new SamplerAudio("shaker");
  samplerAudio[6] = new SamplerAudio("stick");
  samplerAudio[7] = new SamplerAudio("can");
  
  for (int i = 0; i < TOTAL_TRACKS; i++) {
    //samplerListener[i] = new SamplerListener(i); //give it the index
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
  
  cp5.getWindow().setPositionOfTabs(0, height - 50);
  
}


void draw() {
  background(BG_COLOR);
  
  for (int i = 0; i < TOTAL_TRACKS; i++) {
   
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