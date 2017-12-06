
class SamplerGUI{
 
  int x, y, index;
  int h = 75;
  int w = 150;
  
  
  
  SamplerGUI(int x, int y, int index){
    this.x = x;
    this.y = y;
    this.index = index;
    
    cp5.addBang("play " + index)
       .setPosition(x, y)
       .setSize(20, 20)
       .setId(index)
       .addListener(samplerListener[index-1]);
       ;
    cp5.addBang("load " + index)
       .setPosition(x, y + 40)
       .setSize(20, 20)
       .setId(10 + index)
       .addListener(samplerListener[index-1]);
       ;
  }
 
 
  
  void display() {
    fill(30);
    stroke(70);
    strokeWeight(2);
    rect(x + 30, y, w, h, 5);
  }
  
  
 
}