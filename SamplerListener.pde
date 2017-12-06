public class SamplerListener implements ControlListener {
  
  int index;
  
  SamplerListener(int index) {
    this.index = index;
  }
    
  void controlEvent(ControlEvent event) {
    println(event.getController().getId());
    
    if (event.getController().getId() == index) {
      samplerAudio[index].play();
    } 
    else if (event.getController().getId() == index + 10) {
      selectInput("Select a sample to load:", "loadfile", null, this); 
    }
  }
  
  public void loadfile(File selection) {
    if (selection != null) {
     
       String path = selection.getAbsolutePath();
       samplerAudio[index] = new SamplerAudio(path);
       samplerGUI[index].redrawSamplerText(path.substring(path.lastIndexOf("/") + 1));
      
    }
    
  }
}