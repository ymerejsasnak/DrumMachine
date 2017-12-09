
class SamplerGUI{
 
  int x, y, index;
  int h = SAMPLER_HEIGHT;
  int w = SAMPLER_WIDTH;
  Textlabel sampleLabel;
  
  
  
  SamplerGUI(int index){
    
    for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLER; sampleIndex++) {
      this.x = w * index % width;
      this.y = h * int(index / (width/w)) + sampleIndex * 50;
      this.index = index * 10 + sampleIndex;
      
      cp5.addButton("play " + index * 10 + sampleIndex)
         .setCaptionLabel("play")
         .setPosition(x + PADDING * 2 + SAMPLER_BUTTON_SIZE, y + PADDING)
         .setSize(SAMPLER_BUTTON_SIZE, SAMPLER_BUTTON_SIZE)
         .setId(index * 10 + sampleIndex)
         //.addListener(samplerListener[index])
         .plugTo(this, "playFile")
         .moveTo("Samples")
         ;
      cp5.addButton("load " + index * 10 + sampleIndex)
         .setCaptionLabel("load")
         .setPosition(x + PADDING, y + PADDING)
         .setSize(SAMPLER_BUTTON_SIZE, SAMPLER_BUTTON_SIZE)
         .setId(100 + index * 10 + sampleIndex)
         //.addListener(samplerListener[index])
         .plugTo(this, "loadFile")
         .moveTo("Samples")
         ;
         
       sampleLabel = cp5.addTextlabel("filename " + index * 10 + sampleIndex)
          .setText(samplerAudio[index].getFilename(sampleIndex))
          .setPosition(x + SAMPLER_BUTTON_SIZE * 2 + PADDING * 3, y + PADDING)
          .setFont(createFont("Arial", 20))
          .moveTo("Samples")
       ;
    }
       
  }
 
    
  void playFile() {
   // int sampleIndex = 
    //samplerAudio[index].samplers[sampleIndex].trigger();
  }
 
  void loadFile() {
    
  }

  
 
}