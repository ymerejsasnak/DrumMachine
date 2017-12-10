
public class SamplerGUI{
 
  int x, y, index;
  int h = SAMPLER_HEIGHT;
  int w = SAMPLER_WIDTH;
  Textlabel[] sampleLabels = new Textlabel[SAMPLES_PER_SAMPLER];
  
  int currentSampleIndex; // can't think of a workable way to transfer between loadfile and selector methods below 
  
  
  
  SamplerGUI(int index){
    
    for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLER; sampleIndex++) {
      this.x = w * index % width;
      this.y = h * int(index / (width/w)) + sampleIndex * 50;
      this.index = index;
      
      cp5.addButton("play " + index * 10 + sampleIndex)
         .setValue(sampleIndex)
         .setCaptionLabel("play")
         .setPosition(x + PADDING * 2 + SAMPLER_BUTTON_SIZE, y + PADDING)
         .setSize(SAMPLER_BUTTON_SIZE, SAMPLER_BUTTON_SIZE)
         .plugTo(this, "playFile")
         .moveTo("Samples")
         ;
      cp5.addButton("load " + index * 10 + sampleIndex)
         .setValue(sampleIndex)
         .setCaptionLabel("load")
         .setPosition(x + PADDING, y + PADDING)
         .setSize(SAMPLER_BUTTON_SIZE, SAMPLER_BUTTON_SIZE)
         .plugTo(this, "loadFile")
         .moveTo("Samples")
         ;
         
       sampleLabels[sampleIndex] = cp5.addTextlabel("filename " + index * 10 + sampleIndex)
          .setText(samplerAudio[index].filenames[sampleIndex])
          .setPosition(x + SAMPLER_BUTTON_SIZE * 2 + PADDING * 3, y + PADDING)
          .setFont(createFont("Arial", 20))
          .moveTo("Samples")
       ;
    }
       
  }
 
    
  void playFile(int sampleIndex) {
    samplerAudio[index].samplers[sampleIndex].trigger();
  }
 
  void loadFile(int sampleIndex) {
    currentSampleIndex = sampleIndex; // save it 'globally' in class to use in other method below (bad way? but how else??)
    selectInput("Select a sample to load:", "selector", dataFile("data"), this); 
    
      
    
  }

  public void selector(File selection) {
    if (selection != null) {
     
       String path = selection.getAbsolutePath();    
       samplerAudio[index].load(currentSampleIndex, path); 
       String text = path.substring(path.lastIndexOf("/") + 1);
       samplerGUI[index].sampleLabels[currentSampleIndex].setText(text);
      
      
    }
    
  }
 
}