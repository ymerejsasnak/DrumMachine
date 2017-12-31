/*
 Defines/displays the GUI for the sampler settings/fx component (visible on samplers tab)
*/

class SettingsGUI {
  
  int x, y, trackIndex;
  Range[] rangeSettings = new Range[Setting.values().length];
  
  
  SettingsGUI(int trackIndex) {
    this.trackIndex = trackIndex;
    this.x = 120 + SAMPLEGROUP_WIDTH;
    this.y = trackIndex * -(SAMPLEGROUP_TAB_HEIGHT+1);
       
    
    for (int rangeIndex = 0; rangeIndex < rangeSettings.length; rangeIndex++) {
    
      rangeSettings[rangeIndex] = cp5.addRange("randrange" + trackIndex + rangeIndex)
         .setCaptionLabel("")
         .setPosition(x + SETTINGS_LABEL_WIDTH, y + (SETTINGS_SLIDER_HEIGHT + PADDING) * rangeIndex)
         .setSize(SETTINGS_SLIDER_WIDTH, SETTINGS_SLIDER_HEIGHT)
         .moveTo(samplerGUI[trackIndex].samplerGroup)
         ;
         
       cp5.addSlider("stepschange" + trackIndex + rangeIndex)
         .setCaptionLabel("")
         .setPosition(x + SETTINGS_LABEL_WIDTH + SETTINGS_SLIDER_WIDTH + PADDING * 2,
                      y + (SETTINGS_SLIDER_HEIGHT + PADDING) * rangeIndex)
         .setSize(SETTINGS_SLIDER_WIDTH, SETTINGS_SLIDER_HEIGHT)
         .setRange(1, 64)
         .setValue(4)
         .setNumberOfTickMarks(64)
         .snapToTickMarks(true)
         .showTickMarks(false)
         .setSliderMode(Slider.FLEXIBLE)
         .moveTo(samplerGUI[trackIndex].samplerGroup)
         ;
         
       cp5.addLabel(Setting.values()[rangeIndex].toString() + trackIndex)
          .setPosition(x, y + (SETTINGS_SLIDER_HEIGHT + PADDING) * rangeIndex + (SETTINGS_SLIDER_HEIGHT / 3))
          .moveTo(samplerGUI[trackIndex].samplerGroup)
         ;
    }
    
    //set specific ranges and default values (ie off)
    rangeSettings[Setting.GAIN.ordinal()]
      .setRange(-20.0, 10.0)
      .setRangeValues(0.0, 0.0);
    rangeSettings[Setting.PITCH.ordinal()]
      .setRange(0.5, 2.0)
      .setRangeValues(1.0, 1.0);
    rangeSettings[Setting.PAN.ordinal()]
      .setRange(-1.0, 1.0)
      .setRangeValues(0, 0);
            
    rangeSettings[Setting.BIT_DEPTH.ordinal()]
      .setRange(1.0, 16)
      .setRangeValues(16, 16);
    rangeSettings[Setting.BIT_RATE.ordinal()]
      .setRange(10.0, 44100)
      .setRangeValues(44100, 44100);
      
    rangeSettings[Setting.FILTER_FREQ.ordinal()]
      .setRange(0.0, 22050)
      .setRangeValues(22050, 22050);
    rangeSettings[Setting.FILTER_REZ.ordinal()]
      .setRange(0.0, .9)
      .setRangeValues(0, 0);
      
    rangeSettings[Setting.DELAY_TIME.ordinal()]
      .setRange(0.001, 0.2)
      .setRangeValues(0.2, 0.2);
    rangeSettings[Setting.DELAY_FEEDBACK.ordinal()]
      .setRange(0, 0.99)
      .setRangeValues(0, 0);
    
  }
  
  
  
}