/*
 Defines/displays the GUI for the sampler settings/fx component (visible on samplers tab)
*/

class SettingsGUI {
  
  int x, y, trackIndex;
  Range[] rangeSettings = new Range[11];
  
  
  SettingsGUI(int trackIndex) {
    this.trackIndex = trackIndex;
    this.x = 120 + SAMPLEGROUP_WIDTH;
    this.y = trackIndex * -(SAMPLEGROUP_TAB_HEIGHT+1);
    
    
    // note try using array of ints to connect with range values and use THOSE in other class?????
    
    
    
    for (int rangeIndex = 0; rangeIndex < 11; rangeIndex++) {
    
      rangeSettings[rangeIndex] = cp5.addRange("randrange" + trackIndex + rangeIndex)
         .setPosition(x + PADDING * 10 + SETTINGS_SLIDER_WIDTH, y + 50 * rangeIndex + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLEGROUP_BUTTON_SIZE)
         .moveTo(samplerGUI[trackIndex].samplerGroup)
         ;
       cp5.addSlider("stepschange" + trackIndex + rangeIndex)
         .setPosition(x + PADDING * 20 + SETTINGS_SLIDER_WIDTH * 2, y + 50 * rangeIndex + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLEGROUP_BUTTON_SIZE)
         .setRange(1, 64)
         .setValue(4)
         .setNumberOfTickMarks(64)
         .snapToTickMarks(true)
         .showTickMarks(false)
         .moveTo(samplerGUI[trackIndex].samplerGroup)
         ;
         
       cp5.addLabel(Setting.values()[rangeIndex].toString() + trackIndex)
          .setPosition(x, y + 50 * rangeIndex + PADDING) //very rough
          .moveTo(samplerGUI[trackIndex].samplerGroup)
         ;
    }
    
    //set specific ranges and default values (ie off)
    rangeSettings[Setting.VOLUME.ordinal()]
      .setRange(0.0, 1.0)
      .setRangeValues(1.0, 1.0);
    rangeSettings[Setting.PITCH.ordinal()]
      .setRange(0.5, 2.0)
      .setRangeValues(1.0, 1.0);
    rangeSettings[Setting.PAN.ordinal()]
      .setRange(-1.0, 1.0)
      .setRangeValues(0, 0);
       
    
    rangeSettings[Setting.FILTER_FREQ.ordinal()]
      .setRange(0.0, 22050)
      .setRangeValues(22050, 22050);
    rangeSettings[Setting.FILTER_REZ.ordinal()]
      .setRange(0.0, 1.0)
      .setRangeValues(0, 0);
      
    rangeSettings[Setting.BIT_DEPTH.ordinal()]
      .setRange(0.0, 16)
      .setRangeValues(16, 16);
    rangeSettings[Setting.BIT_RATE.ordinal()]
      .setRange(0.0, 44100)
      .setRangeValues(44100, 44100);
      
    rangeSettings[Setting.DELAY_TIME.ordinal()]
      .setRange(0.1, 1.0)
      .setRangeValues(1.0, 1.0);
    rangeSettings[Setting.DELAY_FEEDBACK.ordinal()]
      .setRange(0, 0.99)
      .setRangeValues(0, 0);
    
  }
  
  
  
}