int windowWidth = 1920; // 16/9
int windowHeight = 1080;
int numCols = 8;
int numRows = 5;
int flakeBox = windowHeight / numRows;
int flakeSize = (int) (flakeBox * 0.8);
int gap = flakeBox - flakeSize;
int rotationCycleX = 200;
int rotationCycleY = 300;
int rotationCycleZ = 400;
int countX;
int countY;
int countZ;
int numFrames = 1000;
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
  pointLight(255, 0, 0, 0, 500, 300);
  pointLight(0, 0, 255, 1600, 500, 200);
  //lightSpecular(0, 255, 255);
  shininess(00);
  //specular(0, 255, 255);
  //translate(1920/2, windowHeight/2, 0);
  //sphere(120);
  
  //snowflake.drawSnowflake(windowWidth / 2, windowHeight / 2, 0);
  drawRowsAndColumns();
  
  if (++frameNo == numFrames) {
    noLoop();
  }
  
  // saveFrame
}

void drawRowsAndColumns() {
  double rotationX = getRotation(countX++, rotationCycleX);
  double rotationZ = getRotation(countZ++, rotationCycleZ);

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
