/* TO DO:

NEXT

-CLEANUP - main file - done
         - constants - did some, need to work on values more and adding a few more when magic numbers found
         
         
         
-rename/restructure classes? (ie seq class has 8 track classes, etc...sampler has samplegroups????)


-add adsr (or damp?) with attack and decay added to settings (think about how to make this work best)
-add granulate(steady or random?) to audio chain and settings?

-begin making more samples to use (at least a good default set)


SAMPLER
-save file path from loading file so selection dialog goes back to last folder used
-unload/clear sample, unload/clear samplegroup, unload/clear all samplegroups
? should individual sample play button play clean or play based on settings??? (currently settings)
? individual volume knob for each sample?


SAMPLER SETTINGS
-user settable change speed (ie line ugen duration value)
-initialize settings/randomize settings
? - ok that these affect whole track, not set separately per voice? or have an option to switch? (static vs dynamic)?
 (also, if above is fine, change pitch control to tickrate ugen


SEQUENCER TRACKS -
-mute/solo buttons?
-????step note value (not just 16th, also 8th, dotted, triplet, etc) - even more complex ones? (5/7/etc)
 (how do i do this cleanly???)
 -swing notes?
 ?-per track volume/gain also for more fine tuning?
!!!-add linked restart and repeat (ie all same) - more randomize options too?
  (this should work much better now that I have 8 samplerinstruments (1 each track) rather than only one at a time (stupid)


MASTER (really just SEQUENCER if do the multi seq idea below)
-clear all tracks/randomize all tracks (smart random based on beats/measures - on beat or syncopated)
--randomize tempo slider (subtle to CRAZY)  (maybe a # of steps per change option too?) or do by step/beat/measure like other stuff?
- master volume/gain too?


MASTER
-record to file
-preset saving/loading (also able to save/load parts separately: sequence, settings, samples?)
-initialize all/randomize all
-add limiter to end of audio chain for all?  -add basic level monitor?  -basic output waveform drawing?


WAVS/PRESETS: (and so many more possible)
-drum n bass, hiphop, idm, glitch/noise, generative ambient, generative minimalist, etc.


FUTURE/OTHER
-sequencer can be arbitrarily big with scrolling window and zoom in/out ?????
-add midi output (ie, write sequence to midi file)
-maybe? - have multiple sequencers in subtab setup (use group? accordion?)
      -and then have 3rd tab(song?) for sequencing the sequencers! (using completely configurable step#s and loop times?)
      -each sequencer can have its own tempo?
      -or settable (or drawable!) tempo map that controls tempo over course of playlist (auto set to default tempo? or what?)
         (ie a single sequence can be given various tempos depending on how its defined in this song page)
      -also, when inputing individual sequences into pattern, can choose which tracks are muted on a per seq instance in pattern basis) 
        (ie same pattern easily reusable with just less/more elements cause they're all actually in one sequence)
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
   
  // create necessary objects for all tracks                
  for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
    samplerAudio[trackIndex] = new SamplerAudio(trackIndex);
    samplerGUI[trackIndex] = new SamplerGUI(trackIndex);
    settingsGUI[trackIndex] = new SettingsGUI(trackIndex);
    sequencerGUI[trackIndex] = new SequencerGUI(trackIndex);
  }
  masterGUI = new MasterGUI();
  
}


void draw() {
  background(BG_COLOR);
  
  // cp5 automatically draws its controls as long as draw is running
  
  // draw sequencer steps if on that tab
  for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
    if (sequencerTab.isActive()) {
      sequencerGUI[trackIndex].drawGUI();
    }
  }

  // react to mouse if on sequencer tab
  if (mousePressed && sequencerTab.isActive()) {
    // this runs through all tracks, then all steps in each track, to determine if a step was clicked on
    // there is no discernable performance issue but note there are a lot of steps to check each frame the mouse is pressed
    for(int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
      sequencerGUI[trackIndex].clickCheck(mouseX, mouseY, mouseButton); 
    }
  }
}
  