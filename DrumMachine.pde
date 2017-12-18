// IDM: Idiosyncratic Drum Machine

/* TO DO:

NEXT
-endless: code cleanup, comments, refactoring, gui improvements

-implement last settings: start offset and filter type (just do filter type per samplegroup, not in 'settings')
-begin making more samples to use (and hardcode an easy way to load themfor now)
-implement line ugens for value changes so as to avoid sudden sharp changes (and thus clicks in more pure sounds)
-reversable samples
-for some of above: initially also(?) load file as audiosample in order to get sample array information
   (or figure out how to do this w/ buffer?)
-patch and unpatch new ugens for each setting so changes don't affect samples already playing?
    (actually, having it be an option either way is good, both sound good in certain situations)

SAMPLER
-each *individual* sample should also at least have it's own volume knob ... and filter TYPE
-save file path from loading file so selection dialog goes back to last folder used (maybe not if sdrop)
-unload/clear sample, unload/clear samplegroup, unload/clear all samplegroups
-make sure with multiple samples there are no issues (ie some empty, none loaded, etc) (maybe use arraylist instead?)
-better/cleaner loading of default samples
-use sDrop for drag+drop of samples into sampler (much easier!) -- maybe even make a file browser window as part of this if possible?


SAMPLER SETTINGS
-initialize settings/randomize settings
--note retrigger (% prob, rate, # retrigs) (best way - make second instrument that does the retrigger, calls itself x times)
  (while internally more of a seq thing, acts like more of an effect, so at least gui-wise put it in settings...
     ... but internally maybe handle it in sequencer???)

SEQUENCER - individual track
total controls/buttons need to add: mute, solo, step value, clear track, % triggers (2) )

-volume per step!! (redo STEP class, build this in, volume based on where you click y value)
-mute / solo
-step note value (not just 16th, also 8th, dotted, triplet, etc) - even more complex ones? (5/7/etc)
-clear track

-? % trigger on an off note / % don't trigger an on note



SEQUENCER - all 
-global/all-tracks of some of above controls 
% jump to random step/beat/measure (settable multiple so can jump to random 2steps or random 4steps, etc)
% restart at step 0
% repeat current (# of repeats, steps(/beats/measures?) per repeat)
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

SamplerGUI[] samplerGUI = new SamplerGUI[8];

SettingsGUI[] settingsGUI = new SettingsGUI[8];

SequencerGUI[] sequencerGUI = new SequencerGUI[8];

MasterGUI masterGUI;

Tab sequencerTab, samplerTab;
Accordion samplerAccordion;


ControlFont sampleBarFont, tabFont;

void setup() {
  size(1200, 800);
  background(BG_COLOR);
  
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
  
  
  cp5 = new ControlP5(this);
  
  
  
  sampleBarFont = new ControlFont(createFont("Arial", 25));
  tabFont = new ControlFont(createFont("Arial", 15));
  
  
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
   
  sequencerTab = cp5.addTab("Sequencer")
    //.setFont(tabFont)
    .setActive(true)
    .setHeight(TAB_HEIGHT)
    .setWidth(TAB_WIDTH)
  ;
  samplerTab = cp5.addTab("Samples")
    //.setFont(tabFont)
    .setHeight(TAB_HEIGHT)
    .setWidth(TAB_WIDTH)
  ;
  
  cp5.getWindow().setPositionOfTabs(PADDING, height - TAB_HEIGHT - PADDING);
  
  samplerAccordion = cp5.addAccordion("samplerAccordion")
                        .setMinItemHeight(0)
                        .moveTo("Samples")
                    ;
   
                    
  
  for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
    
    samplerGUI[trackIndex] = new SamplerGUI(trackIndex);
    
    settingsGUI[trackIndex] = new SettingsGUI(trackIndex);
    
    sequencerGUI[trackIndex] = new SequencerGUI(trackIndex);
  }
  masterGUI = new MasterGUI();
 
 
  
}


void draw() {
  background(BG_COLOR);
  
  for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
   
    if (sequencerTab.isActive()) {
      sequencerGUI[trackIndex].drawGUI();
    }
  }

 
  
}



void mousePressed() {
  if (!sequencerTab.isActive()) {
    return;
  }
  for(int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
    sequencerGUI[trackIndex].clickCheck(mouseX, mouseY, mouseButton); 
  }
}