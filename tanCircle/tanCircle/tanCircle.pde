float minX = -4;
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 5;
float stepSize = .05;
float r = (maxX - minX) * .01;

void setup() {
  size(1000, 1000);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  fill(100, 0);
  beginShape();
  for (float x = minX; x < maxX; x += stepSize) {
    float y = f(x);
//    float x_ = mapXToScreen(x);
//    float y_ = mapYToScreen(y);
//    vertex(x_, y_);
    float yPrime = fPrime(x);
    float rScaled = r * yPrime * yPrime;
    float yDelta = rScaled/(sqrt(1 + (yPrime * yPrime)));
    float yCenter = y + yDelta;
    float yICenter = y - yDelta;
    float xCenter = x - yPrime * (yCenter - y);
    float xICenter = x - yPrime * (yCenter - y);
    float screenDiameter = rScaled/(maxX - minX) * width * 2;
    stroke(0, stepSize * 1000);
    ellipse(mapXToScreen(xCenter), mapYToScreen(yCenter), screenDiameter, screenDiameter);    
    ellipse(mapXToScreen(xICenter), mapYToScreen(yICenter), screenDiameter, screenDiameter);
  }
  endShape();
}

float f(float x) {
  return x * x;
}

float fPrime(float x) {
  return 2 * x;
}

float mapXToScreen(float x) {
  return (x - minX)/(maxX - minX)* width - width/2;
}

float mapYToScreen(float y) {
  return height/2 -(y - minY)/(maxY - minY)* height;
}
