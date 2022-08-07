class Snowflake {
  int flakeSize;
  int half;
  int quarter;
  int eighth;
  float sixth = PI / 3.0; // Sixth of a circle in radians
  
  float twelfth = PI / 6.0; // twentyFourth of a circle in radians
  float cosineOfTwelfth = cos(twelfth);
  float sineOfTwelfth = sin(twelfth);
  
  float twentyFourth = PI / 12.0; // twentyFourth of a circle in radians
  float cosineOfTwentyFourth = cos(twentyFourth);
  float sineOfTwentyFourth = sin(twentyFourth);
  
  float eighteenth = PI / 9.0;
  float cosineOfEighteenth = cos(eighteenth);
  float sineOfEighteenth = sin(eighteenth);
  
  float fiveTwentyFourth = twentyFourth * 5.0;
  float cosineOfFiveTwentyFourth = cos(fiveTwentyFourth);
  float sineOfFiveTwentyFourth = sin(fiveTwentyFourth);
  
  float thirtySixth = PI / 18.0;
  float sevenThirtySixths = 7.0 * thirtySixth;
  float cosineOfSevenThirtySixth = cos(sevenThirtySixths);
  float sineOfSevenThirtySixth = sin(sevenThirtySixths);

  Snowflake(int size) {
    flakeSize = size;
    half = flakeSize / 2;
    quarter = flakeSize / 4;
    eighth = flakeSize / 8;
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

  void drawInnerHex() {
    double innerRadius = flakeSize * 0.04;
    double nextRadius = flakeSize * 0.06;
    double thirdRadius = flakeSize * 0.08;
    
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
    
    
    println(x1, y1, x2, y2);
    println(x3, y3, x4, y4);
    
  }
  
  void drawSegment() {
    line(0, 0, 0, half);
  }
  
}
