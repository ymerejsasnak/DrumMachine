/* 
  Defines/displays the GUI components for the samplers
*/

public class SamplerGUI{
 
  int x = SAMPLEGROUP_XPOS;
  int y, trackIndex;
  int w = SAMPLEGROUP_WIDTH;
  Textlabel[] sampleLabels = new Textlabel[SAMPLES_PER_SAMPLEGROUP];
  
  int currentSampleIndex; // can't think of a workable way to send index from loadfile to selector method below so using this var
  
  Group samplerGroup;
  
  
  SamplerGUI(int trackIndex){
    
    samplerGroup = cp5.addGroup("sampler " + trackIndex).setBarHeight(SAMPLEGROUP_TAB_HEIGHT).setFont(sampleBarFont).hideArrow();
    
    this.y = trackIndex * -(SAMPLEGROUP_TAB_HEIGHT + 1); // need to adjust otherwise accordion shifts each 1 down more and more
    
    for (int sampleIndex = 0; sampleIndex < SAMPLES_PER_SAMPLEGROUP; sampleIndex++) {
      int sampleY = y + sampleIndex * SAMPLE_HEIGHT; 
      this.trackIndex = trackIndex;
      
      cp5.addButton("play " + trackIndex * 10 + sampleIndex)
         .setValue(sampleIndex)
         .setCaptionLabel("play")
         .setPosition(x + PADDING * 2 + SAMPLEGROUP_BUTTON_SIZE, sampleY + PADDING)
         .setSize(SAMPLEGROUP_BUTTON_SIZE, SAMPLEGROUP_BUTTON_SIZE)
         .plugTo(this, "playFile")
         .moveTo(samplerGroup)
         ;
      cp5.addButton("load " + trackIndex * 10 + sampleIndex)
         .setValue(sampleIndex)
         .setCaptionLabel("load")
         .setPosition(x + PADDING, sampleY + PADDING)
         .setSize(SAMPLEGROUP_BUTTON_SIZE, SAMPLEGROUP_BUTTON_SIZE)
         .plugTo(this, "loadFile")
         .moveTo(samplerGroup)
         ;
         
       sampleLabels[sampleIndex] = cp5.addTextlabel("filename " + trackIndex * 10 + sampleIndex)
          .setText(samplerAudio[trackIndex].filenames[sampleIndex])
          .setPosition(x + SAMPLEGROUP_BUTTON_SIZE * 2 + PADDING * 3, sampleY + PADDING)
          .setFont(createFont("Arial", 20))
          .moveTo(samplerGroup)
       ;
    }
    
    
    cp5.addRadioButton("randomType" + trackIndex)
       .setItemsPerRow(1)
       .addItem("Random" + trackIndex, RandomType.RANDOM.ordinal())
       .addItem("Avoid Previous" + trackIndex, RandomType.AVOID_PREVIOUS.ordinal())
       .addItem("Cycle" + trackIndex, RandomType.CYCLE.ordinal())
       .setPosition(x + PADDING, y + (SAMPLE_HEIGHT + PADDING) * 4)
       .plugTo(this, "chooseRandom")
       .moveTo(samplerGroup)
    ;
    
    samplerAccordion.addItem(samplerGroup);
       
  }
 
    
  void playFile(int sampleIndex) {
    samplerAudio[trackIndex].samplers[sampleIndex].trigger();
  }
 
 
  void loadFile(int sampleIndex) {
    currentSampleIndex = sampleIndex; // save it 'globally' in class to use in other method below (bad way? but how else??)
    selectInput("Select a sample to load:", "selector", dataFile("data"), this);   
  }


  public void selector(File selection) {
    if (selection != null) {
     
       String path = selection.getAbsolutePath();    
       samplerAudio[trackIndex].load(currentSampleIndex, path); 
       String text = path.substring(path.lastIndexOf("/") + 1);
       samplerGUI[trackIndex].sampleLabels[currentSampleIndex].setText(text);      
    }
  }
  
  
  void chooseRandom(int randomTypeIndex) {
    samplerAudio[trackIndex].randomType = RandomType.values()[randomTypeIndex];
    println(samplerAudio[trackIndex].randomType);
  }
 
}