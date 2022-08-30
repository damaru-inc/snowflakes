class Snowflake {
  int flakeSize;
  int halfFlakeSize;

  float sixth = PI / 3.0; // Sixth of a circle in radians
  float eighth = PI / 4.0;
  float cosineOfEighth = cos(eighth);
  float sineOfEighth = sin(eighth);
  
  float twelfth = PI / 6.0; // twentyFourth of a circle in radians
  float cosineOfTwelfth = cos(twelfth);
  float sineOfTwelfth = sin(twelfth);
  
  float thirtySixth = PI / 18.0;
  float sevenThirtySixths = 7.0 * thirtySixth;
  float cosineOfSevenThirtySixth = cos(sevenThirtySixths);
  float sineOfSevenThirtySixth = sin(sevenThirtySixths);
  
  /*
  float twentyFourth = PI / 12.0; // twentyFourth of a circle in radians
  float cosineOfTwentyFourth = cos(twentyFourth);
  float sineOfTwentyFourth = sin(twentyFourth);
  
  float eighteenth = PI / 9.0;
  float cosineOfEighteenth = cos(eighteenth);
  float sineOfEighteenth = sin(eighteenth);
  
  float fiveTwentyFourth = twentyFourth * 5.0;
  float cosineOfFiveTwentyFourth = cos(fiveTwentyFourth);
  float sineOfFiveTwentyFourth = sin(fiveTwentyFourth);
  
  */

  Snowflake(int size) {
    flakeSize = size;
    halfFlakeSize = flakeSize / 2;
  }
  
  void drawSnowflake(int x, int y, double rotation) {
    
   pushMatrix();
   translate(x, y);
    
   rotate((float) rotation);
   for (int i = 0; i < 6; i++) {
    drawInnerHex();
    drawSegment();
    rotate((float) sixth);
   }
    
   popMatrix();
 }
 
 void drawSnowflake() {
   pushMatrix();
   for (int i = 0; i < 6; i++) {
    drawSegment();
    rotate((float) sixth);
   }    
   popMatrix();
 }

  void drawSegment() {
    line(0, 0, 0, halfFlakeSize);
    drawInnerHex();
    drawArms();
  }
  
  void drawArms() {
    drawArm(flakeSize * 0.15, flakeSize * 0.2);
    drawArm(flakeSize * 0.25, flakeSize * 0.2);
    drawArm(flakeSize * 0.35, flakeSize * 0.1);
  }

  void drawArm(float rad, float len) {
    pushMatrix();
    translate(0f, rad);
    int x = (int) (sineOfEighth * len);
    int y = (int) (cosineOfEighth * len);
    line(0, 0, x, y);
    line(0, 0, -x, y);
    popMatrix();
  }

  void drawInnerHex() {
    double innerRadius = flakeSize * 0.05;
    double nextRadius = flakeSize * 0.15;
    double thirdRadius = flakeSize * 0.2;
    
    int x1 = 0;
    int y1 = (int) innerRadius;
    int x2 = (int) (cosineOfTwelfth * innerRadius);
    int y2 = (int) (sineOfTwelfth * innerRadius);
    line(x1, y1, x2, y2);
    
    double dx = x2 - x1;
    double dy = y2 - y1;
    int x3 = (int) (dx / 3.0 + x1);
    int y3 = (int) (dy / 3.0 + y1);
    int x4 = (int) (cosineOfSevenThirtySixth * nextRadius);
    int y4 = (int) (sineOfSevenThirtySixth * nextRadius);
    line(x3, y3, x4, y4);
    line(-x3, y3, -x4, y4);
    line(-x4, y4, x4, y4);
    
    // Now make the triangle above the rhombus
    int y5 = (int) thirdRadius;
    line(x4, y4, 0, y5);
    line(-x4, y4, 0, y5);
    
    
    //println(x1, y1, x2, y2);
    //println(x3, y3, x4, y4);
    
  }
  
  
}
