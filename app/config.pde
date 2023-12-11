// some helpful constants 

// SCREEN SCALES
// helps scale canvas to be 1:1 at smaller sizes
float MACBOOK_15_SCALE = 0.4912;
float MACBOOK_13_SCALE = 0.5;
float LG_DISPLAY_SCALE = 0.366;

// PEN SIZES  (MM)
float RAPIDOGRAPH_0 = 0.35;
float RAPIDOGRAPH_7 = 2.0;
float BIC_INTENSITY = 0.5;
float POSCA_3M = 1.2;
float POSCA_5M = 2.4;
float PILOT_V5 = 0.5;
float PILOT_V7 = 0.7;

// ----------------------------
// ### PROJECT CONFIG ###

// SCREEN SETTINGS 
boolean useRetinaDisplay = true;
boolean fullscreen = true;
float displayScale = MACBOOK_13_SCALE;

// PRINT SETTINGS (in inches)
float printW = 6;
float printH = 4;

// PLOTTER SETTINGS (in inches)
float maxPlotW = 17;
float maxPlotH = 11;
boolean constrainToPlotArea = false;

// pen thickness (in mm)
float penSize = RAPIDOGRAPH_0; 

// save a PNG preview alongside SVG
boolean savePNGPreview = true;

// ----------------------------
// ### SNOWFLAKE SETTINGS ###

// inset the placement of snowflakes
// these margins are ignored when using a mask image
int marginTop = 200;
int marginRight = 80;
int marginBottom = 90;
int marginLeft = 80;

// snowflake size
int maxFlakeSize = 40;
int minFlakeSize = 10; 

// minimum space between flakes
int flakePadding = 14;

// use a B&W image mask to indicate where to draw snowflakes
boolean useMask = false;
String maskImagePath = "mask-snowfall.png";