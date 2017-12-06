
class SamplerGUI{
 
  int x, y, index;
  int h = 75;
  int w = 150;
  
  
  SamplerGUI(int x, int y, int index){
    this.x = x;
    this.y = y;
    this.index = index;
    
    cp5.addButton("play " + index)
       .setCaptionLabel("play")
       .setPosition(x, y)
       .setSize(20, 20)
       .setId(index)
       .addListener(samplerListener[index]);
       ;
    cp5.addButton("load " + index)
       .setCaptionLabel("load")
       .setPosition(x, y + 40)
       .setSize(20, 20)
       .setId(10 + index)
       .addListener(samplerListener[index]);
       ;
  }
 
    
  
 
  
  void redrawSampler() {
    fill(50);
    noStroke();
    rect(x, y, w, h + 20);
    
    fill(30);
    stroke(70);
    strokeWeight(2);
    rect(x + 30, y, w, h, 5);
    
    redrawSamplerText(samplerAudio[index].filename);

  }
  
  void redrawSamplerText(String text) {
    fill(200);
    textSize(10);
    //ugly way to extract  filename from full path/file name....butonly linux w/ the '/'?
    text(text, x + 45, y + h + 20);
  }
  
 
}