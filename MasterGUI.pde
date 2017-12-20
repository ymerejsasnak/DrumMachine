/*
  Defines/displays "master controls" visible on both tabs ("global"), such as PLAY, STOP, etc
*/

class MasterGUI {
  
  int tempo = DEFAULT_TEMPO;
  boolean playing = false;
  int y = height - MASTER_HEIGHT;
  
  int restartOnStep = 0;
  int restartOnBeat = 0;
  int restartOnMeasure = 0;
  
  int repeatStep = 0;
  int repeatBeat = 0;
  int repeatMeasure = 0;
  
  
  MasterGUI() {
    
    cp5.addButton("play")
       .setCaptionLabel("PLAY")
       .setPosition(PADDING, y + PADDING)
       .setSize(MASTER_BUTTON_WIDTH, MASTER_BUTTON_HEIGHT)
       .plugTo(this)
       .moveTo("global") // always visible (tabs)
    ;
    cp5.addButton("stopIt") //can't name it stop
       .setCaptionLabel("STOP")
       .setPosition(MASTER_BUTTON_WIDTH + PADDING * 2, y + PADDING)
       .setSize(MASTER_BUTTON_WIDTH, MASTER_BUTTON_HEIGHT)
       .plugTo(this)
       .moveTo("global")
    ;
    cp5.addSlider("tempo")
       .setCaptionLabel("TEMPO")
       .setPosition(MASTER_BUTTON_WIDTH * 2 + PADDING * 3, y + PADDING)
       .setSize(TEMPO_WIDTH, TEMPO_HEIGHT)
       .setSliderMode(Slider.FLEXIBLE)
       .setRange(MIN_TEMPO, MAX_TEMPO)
       .setValue(tempo)
       .plugTo(this)
       .moveTo("global")
    ;
    
   
    
    cp5.addSlider("restartOnStep")
      
      .setPosition(500, 700)
      .setRange(0, 50)
      .setValue(0)
      .plugTo(this)
      .moveTo("global")
    ;
    
    cp5.addSlider("restartOnBeat")
      
      .setPosition(600, 700)
      .setValue(0)
      .plugTo(this)
      .moveTo("global")
    ;
    
    cp5.addSlider("restartOnMeasure")
      
      .setPosition(700, 700)
      //.setRange(0, 50)
      .setValue(0)
      .plugTo(this)
      .moveTo("global")
    ;
    
    
    cp5.addSlider("repeatStep")
      
      .setPosition(500, 750)
      .setRange(0, 90)
      .setValue(0)
      .plugTo(this)
      .moveTo("global")
    ;
    
    cp5.addSlider("repeatBeat")
      
      .setPosition(600, 750)
      .setValue(0)
      .plugTo(this)
      .moveTo("global")
    ;
    
    cp5.addSlider("repeatMeasure")
      
      .setPosition(700, 750)
      //.setRange(0, 50)
      .setValue(0)
      .plugTo(this)
      .moveTo("global")
    ;
  }
  
 
  public void play() {
    if (!playing) {
      out.setTempo(tempo);
      out.playNote(0, SIXTEENTH, new SampleInstrument());
      playing = true;
    }   
  }
  
  
  public void stopIt() {
    playing = false;
    for (int trackIndex = 0; trackIndex < TOTAL_TRACKS; trackIndex++) {
      SequencerGUI thisTrack = sequencerGUI[trackIndex];
      thisTrack.steps[thisTrack.currentStep].playing = false;
      thisTrack.currentStep = 0;
    }    
  } 

}