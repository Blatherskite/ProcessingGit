float minX = -4;
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 5;
float stepSize = .2;

void setup() {
  size(500, 500);
  background(255);
  translate(width/2, height/2);
  stroke(200,0,0);
  strokeWeight(1);
  drawXAxis();
  drawYAxis();
  stroke(0);
  for(float x = -3; x < 3; x += stepSize) {
    float slope = 2 * x;
    float y = x*x;
//    float slope = exp(x);
//    float y = exp(x);
    line(mapXToScreen(x-dX, minX, maxX), mapYToScreen(-slope*dX+y, minY, maxY), mapXToScreen(x+dX, minX, maxX), mapYToScreen(slope*dX+y, minY, maxY)); //<>//
  }
}

void drawXAxis() {
  drawLine(minX, 0, maxX, 0);
}

void drawYAxis() {
  drawLine(0, minY, 0, maxY);
}

void drawLine(float x0, float y0, float x1, float y1) {
  float mappedX0 = map(x0, minX, maxX, -width/2, width/2);
  float mappedY0 = map(y0, minY, maxY, -height/2, height/2);
  float mappedX1 = map(x1, minX, maxX, -width/2, width/2);
  float mappedY1 = map(y1, minY, maxY, -height/2, height/2);
  line(mappedX0, mappedY0, mappedX1, mappedY1);
}

void drawPointSlopeLineSegment (float x0, float y0, float slope) {
  float xLeft = map(x0, minX, maxX, slope, 0);
  float yLeft = map(y0, minY, maxY, 0, slope);
  float xRight = map(x0, minX, maxX, -slope,0);
  float yRight = map(y0, minY, maxY, 0, -slope);
line(xLeft, yLeft, xRight, yRight);
}

float mapXToScreen(float x, float minX, float maxX) {
  return (x - minX)/(maxX - minX)* width - width/2;
}

float mapYToScreen(float y, float minY, float maxY) {
  return height/2 -(y - minY)/(maxY - minY)* height;
}
