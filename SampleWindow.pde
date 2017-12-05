
class SampleWindow {
 
  int x, y, index;
  int h = 75;
  int w = 200;
  
  SampleWindow(int x, int y, int index){
    this.x = x;
    this.y = y;
    this.index = index;
    
    cp5.addBang("play " + index)
       .setPosition(x, y)
       .setSize(20, 20)
       ;
    cp5.addBang("load " + index)
       .setPosition(x, y + 40)
       .setSize(20, 20)
       ;
  }
 
  void display() {
    fill(30);
    stroke(70);
    strokeWeight(2);
    rect(x + 30, y, w, h, 5);
  }
 
}