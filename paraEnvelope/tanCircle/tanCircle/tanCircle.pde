float minX = -4; //<>//
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 5;
float stepSize = .1;
float r = (maxX - minX) * 2;

void setup() {
    size(750, 750);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  fill(100, 0);
  stroke(0);
  beginShape();
  for (float x = -3; x < 3; x += stepSize) {
    float y = f(x);
    float x_ = mapXToScreen(x);
    float y_ = mapYToScreen(y);
//    vertex(x_, y_);
    float yDelta = r/(sqrt(1 + (fPrime(x) * fPrime(x))));
    float yCenter = y + yDelta;
    float xCenter = x - fPrime(x) * (yCenter - y);
    float screenDiameter = r/(maxX - minX) * width * 2;
    ellipse(mapXToScreen(xCenter), mapYToScreen(yCenter), screenDiameter, screenDiameter);
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
} //<>//
