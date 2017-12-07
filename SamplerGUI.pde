
class SamplerGUI{
 
  int x, y, index;
  int h = SAMPLER_HEIGHT;
  int w = SAMPLER_WIDTH;
  
  boolean needsToDraw = true;
  
  
  SamplerGUI(int index){
    this.x = w * index;
    this.y = 0;
    this.index = index;
    
    cp5.addButton("play " + index)
       .setCaptionLabel("play")
       .setPosition(x + PADDING, y + PADDING)
       .setSize(BUTTON_SIZE, BUTTON_SIZE)
       .setId(index)
       .addListener(samplerListener[index]);
       ;
    cp5.addButton("load " + index)
       .setCaptionLabel("load")
       .setPosition(x + w - PADDING - BUTTON_SIZE  , y + PADDING)
       .setSize(BUTTON_SIZE, BUTTON_SIZE)
       .setId(10 + index)
       .addListener(samplerListener[index]);
       ;
  }
 
    
  
 
  
  void drawGUI() {
    // draw over old first
    fill(BG_COLOR);
    strokeWeight(1);
    rect(x, y, w - 1, h);
    
     String text = samplerAudio[index].getFilename();

    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(CENTER, CENTER);
    text(text, x + w / 2, (y + h) / 2);
    
    needsToDraw = false;
  }
  
 
}