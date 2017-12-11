/*
volume
decay
pitch
pan
start offset

filt type
filt freq
filt rez

bit rate
bit depth

delay fback
delay time


*/
class SettingsGUI {
  
  int x, y, index;
  int h = 500;
  int w = 300;
  
  //Group settingsGroup;
  
  
  SettingsGUI(int index) {
    this.index = index;
    this.x = 200 + SAMPLER_WIDTH;
    this.y = index * -50;
    
    //settingsGroup = cp5.addGroup("settings" + index).setBarHeight(100);
    
    for (int i = 0; i < 12; i++) {
      cp5.addSlider("base" + index + i)
         .setPosition(x + PADDING, y + 50 * i + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLER_BUTTON_SIZE)
         //.plugTo(this, "playFile")
         .moveTo(samplerGUI[index].samplerGroup)
         ;
      cp5.addRange("randrange" + index + i)
         .setPosition(x + PADDING * 10 + SETTINGS_SLIDER_WIDTH, y + 50 * i + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLER_BUTTON_SIZE)
         //.plugTo(this, "playFile")
         .moveTo(samplerGUI[index].samplerGroup)
         ;
       cp5.addSlider("stepschange" + index + i)
         .setPosition(x + PADDING * 20 + SETTINGS_SLIDER_WIDTH * 2, y + 50 * i + PADDING)
         .setSize(SETTINGS_SLIDER_WIDTH, SAMPLER_BUTTON_SIZE)
         //.plugTo(this, "playFile")
         .moveTo(samplerGUI[index].samplerGroup)
         ;
    }
    
    //settingsGroup.moveTo(samplerGUI[index].samplerGroup);
  }
  
  
  
  
  
}