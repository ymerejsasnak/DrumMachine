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
    
    this.y = trackIndex * -(SAMPLEGROUP_TAB_HEIGHT + 1); // need to adjust otherwise accordion shifts each down according to its position in group list
    
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
          .setText("--")
          .setPosition(x + SAMPLEGROUP_BUTTON_SIZE * 2 + PADDING * 3, sampleY + PADDING)
          .setFont(createFont("Arial", 20))
          .moveTo(samplerGroup)
       ;
       
       if (samplerAudio[trackIndex].filenames[sampleIndex] != null) {
         sampleLabels[sampleIndex].setText(samplerAudio[trackIndex].filenames[sampleIndex]);
       }
       
    }
    
    cp5.addRadioButton("filterType" + trackIndex)
       .setItemsPerRow(1)
       .addItem("Low Pass" + trackIndex, 0)
       .addItem("Band Pass" + trackIndex, 1)
       .addItem("High Pass" + trackIndex, 2)
       .activate(0)
       .setNoneSelectedAllowed(false)
       .setPosition(x + PADDING * 2 + 70, y + (SAMPLE_HEIGHT + PADDING) * 4)
       .plugTo(this, "changeFilterType")
       .moveTo(samplerGroup)
    ;
    
    // control to set how it randomly chooses which sample from the group to play
    cp5.addRadioButton("randomType" + trackIndex)
       .setItemsPerRow(1)
       .addItem("Random" + trackIndex, RandomType.RANDOM.ordinal())
       .addItem("Avoid Previous" + trackIndex, RandomType.AVOID_PREVIOUS.ordinal())
       .addItem("Cycle" + trackIndex, RandomType.CYCLE.ordinal())
       .activate(0)
       .setNoneSelectedAllowed(false)
       .setPosition(x + PADDING, y + (SAMPLE_HEIGHT + PADDING) * 4)
       .plugTo(this, "chooseRandom")
       .moveTo(samplerGroup)
    ;
    
    samplerAccordion.addItem(samplerGroup);
       
  }
 
  
  // directly play the file to audition it (see note in TODO)
  void playFile(int sampleIndex) {
    
    samplerAudio[trackIndex].samplers[sampleIndex].trigger();
  
  }
 
 
  // load the file...but note that selectInput has to call another function (selector in this case, below this) which is run in a separate thread
  void loadFile(int sampleIndex) {
    currentSampleIndex = sampleIndex; // save it 'globally' in class to use in other method below (bad way? but how else??)
    selectInput("Select a sample to load:", "selector", dataFile("data"), this);   
  }


  public void selector(File selection) {
    if (selection != null) {
     
       String path = selection.getAbsolutePath();    
       samplerAudio[trackIndex].load(currentSampleIndex, path); 
       String text = path.substring(path.lastIndexOf("/") + 1); // cut out path and just show filename itself
       samplerGUI[trackIndex].sampleLabels[currentSampleIndex].setText(text);      
    }
  }
  
  
  // set randomtype in sampler audio based on radio button for each sample group
  void chooseRandom(int randomTypeIndex) {
    samplerAudio[trackIndex].randomType = RandomType.values()[randomTypeIndex];
  }
  
  // 
  void changeFilterType(int filterIndex) {
    switch (filterIndex) {
      case 0:
        samplerAudio[trackIndex].filterUgen.type = MoogFilter.Type.LP;
        break;
      case 1:
        samplerAudio[trackIndex].filterUgen.type = MoogFilter.Type.BP;
        break;
      case 2:
        samplerAudio[trackIndex].filterUgen.type = MoogFilter.Type.HP;
        break;
    }
  }
 
}