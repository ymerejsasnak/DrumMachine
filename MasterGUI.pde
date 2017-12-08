class MasterGUI {
  
  int tempo = 120;
  boolean playing = false;
  
  MasterGUI() {
    
    cp5.addButton("play")
       .setPosition(0, height - 140)
       .plugTo(this)
    ;
    cp5.addButton("stopIt") //can't name it stop
       .setCaptionLabel("stop")
       .setPosition(0, height - 120)
       .plugTo(this)
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
    for (int i = 0; i < 4; i++) {
      sequencerGUI[i].steps[sequencerGUI[i].currentStep].playing = false;
      sequencerGUI[i].currentStep = 0;
    }
  }
  
}