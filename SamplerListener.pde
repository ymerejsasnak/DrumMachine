//can probably just use plugto and get rid of this whole class (written before I fully understood using plugto)
/*
public class SamplerListener implements ControlListener {
  
  int index;
  
  SamplerListener(int index) {
    this.index = index;
  }
    
  void controlEvent(ControlEvent event) {
    
    if (event.getController().getId() == index) {
      samplerAudio[index].play();
    } 
    else if (event.getController().getId() == index + sampleIndex + 10) {
      selectInput("Select a sample to load:", "loadfile", dataFile("data"), this); 
    }
  }
  
  public void loadfile(File selection) {
    if (selection != null) {
     
       String path = selection.getAbsolutePath();
       samplerAudio[index] = new SamplerAudio(path);
       
       String text = samplerAudio[index].getFilename(sampleIndex);
       samplerGUI[index].sampleLabel.setText(text);
      
      
    }
    
  }
}*/