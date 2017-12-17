// general use padding pixels amount (space between buttons, from edges, etc)
final int PADDING = 10;

// dimensions of main tab buttons ('sequencer' or 'sampler')
final int TAB_WIDTH = 100;
final int TAB_HEIGHT = 50;

// for SAMPLERS and SAMPLEGROUPS
final int SAMPLE_HEIGHT = 50;
final int SAMPLEGROUP_XPOS = 200;
final int SAMPLEGROUP_WIDTH = 300;
final int SAMPLEGROUP_BUTTON_SIZE = 30;
final int SAMPLEGROUP_TAB_HEIGHT = 60;

final int SAMPLES_PER_SAMPLEGROUP = 4;
final int SAMPLER_VOICES = 4;

enum RandomType {
  RANDOM(), AVOID_PREVIOUS, CYCLE
}

// for SETTINGS options in sampler
final int SETTINGS_SLIDER_WIDTH = 200;
final int SETTINGS_LABEL_WIDTH = 100;
final int SETTINGS_SLIDER_HEIGHT = 30;

enum Setting {
  VOLUME, PITCH, PAN, START, BIT_DEPTH, BIT_RATE, FILTER_FREQ, FILTER_REZ, DELAY_TIME, DELAY_FEEDBACK 
}


// for SEQUENCER
final int SEQUENCER_VERTICAL_OFFSET = 100;
final int SEQUENCER_TRACK_HEIGHT = 50;

final int MAX_STEPS = 64;
final int STEP_WIDTH = 14;
final int STEP_SPACING = 2;
final int STEP_HEIGHT = 30;


// for MASTER CONTROLS
final int MASTER_HEIGHT = 150; // ??
final int MASTER_BUTTON_WIDTH = 100;
final int MASTER_BUTTON_HEIGHT = 25;
final int TEMPO_WIDTH = 200;
final int TEMPO_HEIGHT = 25;

final int MIN_TEMPO = 30;
final int MAX_TEMPO = 350;
final int DEFAULT_TEMPO = 160;


// GENERAL
final int TOTAL_TRACKS = 8;

final float QUARTER_NOTE = 0.25f;


// COLORS
final color BG_COLOR = color(30);
//final color TEXT_COLOR = color(200);