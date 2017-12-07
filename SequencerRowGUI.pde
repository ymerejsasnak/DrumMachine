class SequencerRowGUI {
  
   
  int x, y, index;
  int h = 50;
  int w = width;
  
  //boolean needsToDraw = true;
  
  SequencerRowGUI(int index) {
    this.index = index;
    x = 0;
    y = index * (h + PADDING) + 400;
    
    cp5.addMatrix("sequencer " + index)
       .setCaptionLabel("")
       .setPosition(x + PADDING, y + PADDING)
       .setSize(640, h)
       .setGrid(16, 1)
       .setGap(5, 0)
       .setBackground(BG_COLOR)
       
    ;
  }
  
  
  //void drawGUI() {
    
    
  //  needsToDraw = false;
 // }
  
  
  
  
  
  
}