public class SamplerListener implements ControlListener {
  
  int index;
  
  SamplerListener(int index) {
    this.index = index;
  }
    
  void controlEvent(ControlEvent event) {
    
    if (event.getController().getId() == index) {
      samplerAudio[index].play();
    } 
    else if (event.getController().getId() == index + 10) {
      selectInput("Select a sample to load:", "loadfile", dataFile("data"), this); 
    }
  }
  
  public void loadfile(File selection) {
    if (selection != null) {
     
       String path = selection.getAbsolutePath();
       samplerAudio[index] = new SamplerAudio(path);
       samplerGUI[index].needsToDraw = true;
      
      
    }
    
  }
}