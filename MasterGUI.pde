/*
  Defines/displays "master controls" visible on both tabs ("global"), such as PLAY, STOP, etc
*/

class MasterGUI {
  
  int tempo = DEFAULT_TEMPO;
  boolean playing = false;
  int y = height - MASTER_HEIGHT;
  
  
  MasterGUI() {
    
    cp5.addButton("play")
       .setCaptionLabel("PLAY")
       .setPosition(PADDING, y + PADDING)
       .setSize(100, 25)
       .plugTo(this)
       .moveTo("global") // always visible (tabs)
    ;
    cp5.addButton("stopIt") //can't name it stop
       .setCaptionLabel("STOP")
       .setPosition(150, y + PADDING)
       .setSize(100, 25)
       .plugTo(this)
       .moveTo("global")
    ;
    cp5.addSlider("tempo")
       .setCaptionLabel("TEMPO")
       .setPosition(300, y + PADDING)
       .setSize(150, 20)
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