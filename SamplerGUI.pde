
class SamplerGUI{
 
  int x, y, index;
  int h = SAMPLER_HEIGHT;
  int w = SAMPLER_WIDTH;
  
  
  
  SamplerGUI(int index){
    this.x = w * index;
    this.y = 0;
    this.index = index;
    
    cp5.addButton("play " + index)
       .setCaptionLabel("play")
       .setPosition(x + PADDING, y + PADDING)
       .setSize(SAMPLER_BUTTON_SIZE, SAMPLER_BUTTON_SIZE)
       .setId(index)
       .addListener(samplerListener[index])
       .moveTo("Samples")
       ;
    cp5.addButton("load " + index)
       .setCaptionLabel("load")
       .setPosition(x + w - PADDING - SAMPLER_BUTTON_SIZE  , y + PADDING)
       .setSize(SAMPLER_BUTTON_SIZE, SAMPLER_BUTTON_SIZE)
       .setId(10 + index)
       .addListener(samplerListener[index])
       .moveTo("Samples")
       ;
  }
 
    
  
 
  
  void drawGUI() {
    
    
     String text = samplerAudio[index].getFilename();

    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(CENTER, CENTER);
    text(text, x + w / 2, (y + h) / 2);
    
  }
  
 
}