int windowWidth = 1920;
int windowHeight = 1080;
int numCols = 1;
int numRows = 1;
int flakeBox = windowHeight / numRows;
int flakeSize = (int) (flakeBox * 0.8);
int gap = flakeBox - flakeSize;
int rotationCycle = 200;
int numFrames = 1;
int frameNo = 0;

Snowflake snowflake;

void setup() {
  // hd:
  // 1280 x 720
  // full hd:
  size(1920, 1080);
  background(0);
  fill(255);
  stroke(255);
  strokeWeight(2);
  frameRate(30);
  snowflake = new Snowflake(flakeSize);
}

void draw() {
  clear();
  
  snowflake.drawSnowflake(windowWidth / 2, windowHeight / 2, 0);
  
  if (++frameNo == numFrames) {
    noLoop();
  }
  
  // saveFrame
}

void drawRowsAndColumns() {
  double rotation = getRotation();

  for (int row = 0; row < numRows; row++) {
    int y = row * (flakeSize + gap) + (flakeBox / 2);
    for (int col = 0; col < numCols; col++) {
      int x = (col * flakeBox) + (flakeBox / 2);
      snowflake.drawSnowflake(x, y, rotation);
    }
  }
}

double getRotation() {
  double proportion = getProportion(rotationCycle);
  double angle = proportion * PI / 3.0;
  println("frame: ", frameNo, " ", proportion, " " , angle);
  return angle;
}

double getProportion(int cycle) {
  int pointWithinCycle = frameNo % cycle;
  double proportion = (pointWithinCycle) / (double) cycle;
  if (pointWithinCycle > cycle / 2) {
    proportion = 1.0 - proportion;
  }
  return proportion;
}  
