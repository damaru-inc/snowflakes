int windowWidth = 1920; // 16/9
int windowHeight = 1080;
int numCols = 16;
int numRows = 9;
int flakeBox = windowHeight / numRows;
int flakeSize = (int) (flakeBox * 0.8);
int gap = flakeBox - flakeSize;
int rotationCycleX = 7000;
int rotationCycleY = 3000;
int rotationCycleZ = 5000;
int countX;
int countY;
int countZ;
int lightCycleRedX = windowWidth; // was 250

int countRedX = 0;
int countGreenX = windowWidth;
int countBlueX = windowWidth / 2;
int incrementRed = 5;
int incrementGreen = 7;
int incrementBlue = -11;

int framesPerSecond = 30;
int numSeconds = 120;
int numFrames = framesPerSecond * numSeconds;
int frameNo = 0;

Snowflake3D snowflake3D;
Snowflake snowflake;

boolean do3D = true;

void setup() {
  // hd:
  // 1280 x 720
  // full hd:
  size(1920, 1080, P3D);
  background(0);
  //fill(255);
  //stroke(255);
  //noStroke();
  strokeWeight(2);
  frameRate(30);
  snowflake3D = new Snowflake3D(flakeSize);
  snowflake = new Snowflake(flakeSize);
}

void draw() {
  clear();
  //directionalLight(255, 0, 0, 1, 1, -0.5);
  //directionalLight(64, 64, 255, -1, 1, -0.5);
  //lightSpecular(0, 255, 255);
  shininess(1000);
  //specular(0, 255, 255);
  //translate(1920/2, windowHeight/2, 0);
  //sphere(120);
  
  //snowflake.drawSnowflake(windowWidth / 2, windowHeight / 2, 0);
  drawRowsAndColumns();
  //saveFrame("data/f-####.tif");
  
  if (++frameNo == numFrames) {
    noLoop();
  }
  
}

void drawRowsAndColumns() {
  double rotationX = getRotation(countX++, rotationCycleX);
  double rotationZ = getRotation(countZ++, rotationCycleZ);
  
  double proportion = getProportion(countRedX, windowWidth);  
  int redX = (int) lerp(0.0f, (float) windowWidth, (float) proportion);
  incrementRed = getIncrementValue(countRedX, incrementRed, windowWidth);
  countRedX = redX + incrementRed;

  proportion = getProportion(countGreenX, windowWidth);
  int greenX = (int) lerp(0.0f, (float) windowWidth, (float) proportion);
  incrementGreen = getIncrementValue(countGreenX, incrementGreen, windowWidth);
  countGreenX = greenX + incrementGreen;

  proportion = getProportion(countBlueX, windowWidth);
  int blueX = (int) lerp(0.0f, (float) windowWidth, (float) proportion);
  incrementBlue = getIncrementValue(countBlueX, incrementBlue, windowWidth);
  countBlueX = blueX + incrementBlue;

  println("frame: ", frameNo, " redX: ", redX, " greenX: ", greenX, " blueX: ", blueX);
  
  int lightY = windowHeight / 2;
  int lightZ = 300;
  
  pointLight(255, 0, 220, redX, lightY, lightZ);
  pointLight(0, 255, 230, greenX, lightY, lightZ);
  pointLight(0, 0, 255, blueX, lightY, lightZ);

  for (int row = 0; row < numRows; row++) {
    int y = row * (flakeSize + gap) + (flakeBox / 2);
    for (int col = 0; col < numCols; col++) {
      int x = (col * flakeBox) + (flakeBox / 2);
      push();
      translate(x, y);
      rotateX((float) rotationX);
      rotateZ((float) rotationZ);
      //snowflake.drawSnowflake(x, y, rotation);
      //directionalLight(255, 0, 0, 1, 1, -1);
      //directionalLight(0, 0, 255, -1, 1, -1);
      if (do3D) {
        snowflake3D.drawSnowflake();
      } else {
        stroke(255);
        snowflake.drawSnowflake();
      }
      pop();
    }
  }
}

int getIncrementValue(int value, int amount, int max) {
  int nextValue = value + amount;
  if (nextValue < 0 || nextValue > max) return -amount;
  return amount;
}

double getRotation(int count, int rotationCycle) {
  double proportion = getProportion(count, rotationCycle);
  double angle = proportion * PI;// / 3.0;
  //println("count: ", count, " rotationCycle:", rotationCycle, "proportion: ", proportion, " angle: " , angle);
  return angle;
}

double getProportion(int count, int cycle) {
  double proportion = count / (double) cycle;
  //int pointWithinCycle = frameNo % cycle;
  //double proportion = (pointWithinCycle) / (double) cycle;
  //if (pointWithinCycle > cycle / 2) {
  //  proportion = 1.0 - proportion;
  //}
  return proportion;
}  
