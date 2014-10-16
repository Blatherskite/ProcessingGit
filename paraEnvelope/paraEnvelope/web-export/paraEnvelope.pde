float minX = -4;
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 5;
float stepSize = .3;
boolean axisIsVisible = false;

Functor functor;
Functor parabola = new Functor() {
  public float value(float x) {
    return x * x;
  }
  public float slope(float x) {
    return 2 * x;
  }
};
Functor cubic = new Functor() {
  public float value(float x) {
    return x * x * x;
  }
  public float slope(float x) {
    return 3 * x * x;
  }
};
Functor exponential = new Functor() {
  public float value(float x) {
    return exp(x);
  }
  public float slope(float x) {
    return exp(x);
  }
};

interface JavaScript {
  void showValues(float s);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(750, 750);
  functor = parabola;
}

void draw() {
  background(255);
  if (javascript!=null) 
    javascript.showValues(stepSize);
  translate(width/2, height/2);
  stroke(200, 0, 0);
  strokeWeight(1);
  if (axisIsVisible = true) {    
    drawXAxis();
    drawYAxis();
  }
  stroke(0);
  float range = 6;
  for (int i = 0; i < range / stepSize; ++i) {
    float x_ = -3 + i * stepSize;
    float slope = functor.slope(x_);
    float y = functor.value(x_);
    line(mapXToScreen(x_-dX, minX, maxX), mapYToScreen(-slope*dX+y, minY, maxY), mapXToScreen(x_+dX, minX, maxX), mapYToScreen(slope*dX+y, minY, maxY));
  }
}

void setFunctor(String f) {
  if (f.equals("Parabola")) {
    functor = parabola;
  } else if (f.equals("Cubic")) {
    functor = cubic;
  } else {
    functor = exponential;
  }
}

void setStepSize(float d) {
  stepSize = d;
}

void showAxis(boolean show) {
  axisIsVisible = show;
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
  float xRight = map(x0, minX, maxX, -slope, 0);
  float yRight = map(y0, minY, maxY, 0, -slope);
  line(xLeft, yLeft, xRight, yRight);
}

float mapXToScreen(float x, float minX, float maxX) {
  return (x - minX)/(maxX - minX)* width - width/2;
}

float mapYToScreen(float y, float minY, float maxY) {
  return height/2 -(y - minY)/(maxY - minY)* height;
}
interface Functor {
  float value(float x);
  float slope(float x);
}

