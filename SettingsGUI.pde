enum Setting {
  VOLUME, PITCH, PAN, START, FILTER_TYPE, FILTER_FREQ, FILTER_REZ, BIT_DEPTH, BIT_RATE, DELAY_TIME, DELAY_FEEDBACK 
}

class SettingsGUI {
  
  int x, y, index;
  int h = 500;
  int w = 300;
  Range[] rangeSettings = new Range[11];
  
  
  SettingsGUI(int index) {
    this.index = index;
    this.x = 200 + SAMPLER_WIDTH;
    this.y = index * -50;
    
    
    // note try using array of ints to connect with range values and use THOSE in other class?????
    
    
    
    for (int i = 0; i < 11; i++) {
    //  cp5.addSlider("base" + index + i)
     //    .setPosition(x + PADDING, y + 50 * i + PADDING)
     //    .setSize(SETTINGS_SLIDER_WIDTH, SAMPLER_BUTTON_SIZE)
         //.plugTo(this, "playFile")
    //     .moveTo(samplerGUI[index].samplerGroup)
     //    ;
      rangeSettings[i] = cp5.addRange("randrange" + index + i)
         .setPosition(x + PADDING * 10 + SETTINGS_SLIDER_WIDTH, y + 50 * i + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLER_BUTTON_SIZE)
         //.plugTo(this, "playFile")
         .moveTo(samplerGUI[index].samplerGroup)
         ;
       cp5.addSlider("stepschange" + index + i)
         .setPosition(x + PADDING * 20 + SETTINGS_SLIDER_WIDTH * 2, y + 50 * i + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLER_BUTTON_SIZE)
         //.plugTo(this, "playFile")
         .setRange(1, 64)
         .setValue(4)
         .setNumberOfTickMarks(64)
         .snapToTickMarks(true)
         .showTickMarks(false)
         .moveTo(samplerGUI[index].samplerGroup)
         ;
         
       cp5.addLabel(Setting.values()[i].toString() + index)
          .setPosition(x, y + 50 * i) //very rough
          .moveTo(samplerGUI[index].samplerGroup)
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
  
  //temporary I think, just testing
 // void volume(int value) {
  //   for (int i = 0; i < SAMPLES_PER_SAMPLER; i++) {
    //  new Constant(map(value, 0, 100, 0, 1.0)).patch(samplerAudio[index].samplers[i].amplitude);
      
   // }
  //}
  
  
}