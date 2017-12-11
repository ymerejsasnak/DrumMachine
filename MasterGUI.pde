class MasterGUI {
  
  int tempo = 160;
  boolean playing = false;
  int y = height - MASTER_HEIGHT;
  
  boolean needsToDraw = true;
  
  MasterGUI() {
    
    cp5.addButton("play")
       .setPosition(PADDING, y + PADDING)
       .plugTo(this)
       .moveTo("global") // always visible (tabs)
    ;
    cp5.addButton("stopIt") //can't name it stop
       .setCaptionLabel("stop")
       .setPosition(100, y + PADDING)
       .plugTo(this)
       .moveTo("global")
    ;
    cp5.addSlider("tempo")
       .setPosition(200, y + PADDING)
       .setSliderMode(Slider.FLEXIBLE)
       .setRange(MIN_TEMPO, MAX_TEMPO)
       .setValue(tempo)
       .plugTo(this)
       .moveTo("global")
    ;
    
  }
  
 
  
  
  public void play() {
    if (!playing) {
      out.setTempo(tempo);
      out.playNote(0, 0.25f, new SampleInstrument());
      playing = true;
    }
    
  }
  
  public void stopIt() {
    playing = false;
    for (int i = 0; i < TOTAL_TRACKS; i++) {
      sequencerGUI[i].steps[sequencerGUI[i].currentStep].playing = false;
      sequencerGUI[i].currentStep = 0;
    }
    
  }
  
  
 

}