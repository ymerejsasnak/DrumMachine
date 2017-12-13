// IDM: Idiosyncratic Drum Machine

/* TO DO:

NEXT
-cleanup and comment code (ESPECIALLY GLOBALS for magic numbers)!!
-implement last settings: start offset and filter type
-put filter AFTER bitcrush?
-fix up all values/ranges/etc for settings
-begin gui improvements
-begin making more samples to use (and hardcode an easy way to load themfor now)

SAMPLER
-each *individual* sample should also at least have it's own volume knob (if not a couple other things too)
-save file path from loading file so selection dialog goes back to last folder used (maybe not if sdrop)
-unload/clear sample, unload/clear all samples, unload/clear all samplers
-make sure with multiple samples there are no issues (ie some empty, none loaded, etc) (maybe use arraylist instead?)
-better/cleaner loading of default samples
-choice between pure random, avoid previous, and cycle
-use sDrop for drag+drop of samples into sampler (much easier!) -- maybe even make a file browser window as part of this if possible?
-settings should probably be visible at same time as sampler...maybe make it tabbed/grouped/accordion/whatever and only
 show 1 or 2 samplers (with settings!) at a time


SAMPLER SETTINGS
-initialize settings/randomize settings


SEQUENCER - individual
-volume per step!!
-mute button (solo button too?)
-step note value (not just 16th, also 8th, dotted, triplet, etc) - even more complex ones? (5/7/etc)
-settable measure/beat highlighting interval (not just every 16/4)
-clear track/randomize track
-convenience stuff: insert every X beat?, copy/past track, etc 
-? % turn random step on each loop/ % turn random step off each loop
-? % trigger on an off note / % don't trigger an on note


SEQUENCER - all (but maybe would work on individual ones too?)
% jump to random step (settable multiple so can jump to random 2steps or random 4steps, etc)
% restart at step 0
% repeat current (# of repeats, steps per repeat)
-clear all tracks/randomize all tracks


MASTER
-pause button? (or add this to play button if playing)
-record to file
-preset saving/loading
-initialize all/randomize all
-add limiter to end of audio chain for all?


WAVS/PRESETS: (and so many more possible)
-drum n bass
-idm
-experimental/glitch/noise(but rhythmic)
-extreme chaotic abstract/noise/sound collage
-ambient (tonal samples)
-minimalist (drums + tonal)

FUTURE/OTHER
-add midi output
-maybe? - have multiple sequencers in subtab setup (use group? accordion?)
      -and then have 3rd tab(song?) for sequencing the sequencers! (using completely configurable step#s and loop times?)
      -each sequencer can have its own tempo?
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

SettingsGUI[] settingsGUI = new SettingsGUI[8];

SequencerAudio[] sequencerAudio = new SequencerAudio[8];
SequencerGUI[] sequencerGUI = new SequencerGUI[8];

MasterGUI masterGUI;

Tab sequencerTab, samplerTab;
Accordion samplerAccordion;



void setup() {
  size(1200, 800);
  background(BG_COLOR);
  
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
  
  
  cp5 = new ControlP5(this);
  
  // hardcoded default loading for now, depends on names being the same with different indexs as part of filenmaes
  samplerAudio[0] = new SamplerAudio("kick");
  samplerAudio[1] = new SamplerAudio("snareA");
  samplerAudio[2] = new SamplerAudio("snareB");
  samplerAudio[3] = new SamplerAudio("hihat");
  samplerAudio[4] = new SamplerAudio("bongo");
  samplerAudio[5] = new SamplerAudio("shaker");
  samplerAudio[6] = new SamplerAudio("stick");
  samplerAudio[7] = new SamplerAudio("can");
  
  
  cp5.getTab("default").hide(); //not using default tab
   
  sequencerTab = cp5.addTab("Sequencer").setActive(true);
  ;
  samplerTab = cp5.addTab("Samples")
  ;
  
  cp5.getWindow().setPositionOfTabs(0, height - 50);
  
  samplerAccordion = cp5.addAccordion("samplerAccordion")
                        .setMinItemHeight(0)
                        .moveTo("Samples")
                    ;
   
                    
  
  for (int i = 0; i < TOTAL_TRACKS; i++) {
    
    samplerGUI[i] = new SamplerGUI(i);
    
    settingsGUI[i] = new SettingsGUI(i);
    
    sequencerAudio[i] = new SequencerAudio(i);
    sequencerGUI[i] = new SequencerGUI(i);
  }
  masterGUI = new MasterGUI();
 
 
  
  
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
  if (!sequencerTab.isActive()) {
    return;
  }
  for(int i = 0; i < TOTAL_TRACKS; i++) {
    sequencerGUI[i].clickCheck(mouseX, mouseY, mouseButton); 
  }
}