class SamplerListener implements ControlListener {
  
  int index;
  
  SamplerListener(int index) {
    this.index = index;
  }
    
  void controlEvent(ControlEvent event) {
    if (event.getController().getId() == index) {
      samplerAudio[index - 1].play();
    } else if (event.getController().getId() == index + 10) {
      println("load " + index); 
    }
  }
}