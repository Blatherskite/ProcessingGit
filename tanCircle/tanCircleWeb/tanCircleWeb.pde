float minX = -4; //<>// //<>// //<>//
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 5;
float stepSize = .01;
float radiusScale = .01;
float radius = (maxX - minX) * radiusScale;
boolean axisIsVisible = false;

Functor functor;
Functor parabola = new Parabola();
Functor cubic = new Cubic();
Functor exponential = new Exponential();
Functor sine = new Sine();
Functor cotangent = new Cotangent();
Functor cosecant = new Cosecant();
interface JavaScript {
  void showValues(float s);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(750, 750);
  //  parabola.setFrame(minX, maxX, minY, maxY);
  //  cubic.setFrame(minX, maxX, minY, maxY);
  //  sine.setFrame(minX, maxX, minY, maxY);
  //  exponential.setFrame(minX, maxX, minY, maxY);
  //  cotangent.setFrame(minX, maxX, minY, maxY);
  //  cosecant.setFrame(minX, maxX, minY, maxY);
  functor = parabola;
}

void draw() {
  background(255);
  if (javascript!=null) 
    javascript.showValues(stepSize);
  translate(width/2, height/2);
  stroke(255, 0, 0);
  strokeWeight(1);
  if (axisIsVisible) {
    drawXAxis();
    drawYAxis();
  }
  fill(100, 0);
  beginShape();
  for (float x = minX; x < maxX; x += stepSize) {
    float y = functor.value(x);
    //    float x_ = mapXToScreen(x);
    //    float y_ = mapYToScreen(y);
    //    vertex(x_, y_);
    float yPrime = functor.slope(x);
    float rScaled = radius * yPrime * yPrime;
    float yDelta = rScaled/(sqrt(1 + (yPrime * yPrime)));
    float yCenter = y + yDelta;
    float yICenter = y - yDelta;
    float xCenter = x - yPrime * (yCenter - y);
    float xICenter = x - yPrime * (yCenter - y);
    float screenDiameter = rScaled/(maxX - minX) * width * 2;
    stroke(0, stepSize * 1000);
    //    stroke(0, 255*stepSize+10);
    ellipse(mapXToScreen(xCenter), mapYToScreen(yCenter), screenDiameter, screenDiameter);    
    ellipse(mapXToScreen(xICenter), mapYToScreen(yICenter), screenDiameter, screenDiameter);
  }
  endShape();
}

void setFunctor(String f) {
  //  println(f);
  if (f.equals("Parabola")) {
    functor = parabola;
  } else if (f.equals("Cubic")) {
    functor = cubic;
  } else if (f.equals("Exponential")) {
    functor = exponential;
  } else if (f.equals("Sine")) {
    functor = sine;
  } else if (f.equals("Cotangent")) {
    functor = cotangent;
  } else {
    functor = cosecant;
  }
  functor.setFrame(minX, maxX, minY, maxY);
}

void changeFrame(float newMinX, float newMaxX, float newMinY, float newMaxY) {
  functor.setFrame(newMinX, newMaxX, newMinY, newMaxY);
}

float f(float x) {
  return 1/sin(x);
}

float fPrime(float x) {
  return -cos(x)/(sin(x)*sin(x));
}

void setStepSize(float d) {
  stepSize = d * 1.0;
}

void setRadiusScale(float r) {
  radiusScale = r * 1.0;
}

void showAxis(boolean show) {
  axisIsVisible = show;
}

void drawXAxis() {
  drawLine(functor.minX, 0, functor.maxX, 0);
}

void drawYAxis() {
  drawLine(0, functor.minY, 0, functor.maxY);
}

void drawLine(float x0, float y0, float x1, float y1) {
  float mappedX0 = map(x0, functor.minX, functor.maxX, -width/2, width/2);
  float mappedY0 = map(y0, functor.minY, functor.maxY, -height/2, height/2);
  float mappedX1 = map(x1, functor.minX, functor.maxX, -width/2, width/2);
  float mappedY1 = map(y1, functor.minY, functor.maxY, -height/2, height/2);
  line(mappedX0, mappedY0, mappedX1, mappedY1);
}

float mapXToScreen(float x) {
  return (x - minX)/(maxX - minX)* width - width/2;
}

float mapYToScreen(float y) {
  return height/2 -(y - minY)/(maxY - minY)* height;
}

abstract class Functor {
  float minX, minY, maxX, maxY;
  abstract float value(float x);
  abstract float slope(float x);
  void setFrame(float minX_, float maxX_, float minY_, float maxY_) {
    minX = minX_ * 1.0;
    maxX = maxX_ * 1.0;
    minY = minY_ * 1.0;
    maxY = maxY_ * 1.0;
  }
}

class Parabola extends Functor {
  public float value(float x) {
    return x * x;
  }
  public float slope(float x) {
    return 2 * x;
  }
}

class Cubic extends Functor {
  public float value(float x) {
    return x * x * x;
  }
  public float slope(float x) {
    return 3 * x * x;
  }
}

class Sine extends Functor {
  public float value(float x) {
    return sin(x);
  }
  public float slope(float x) {
    return cos(x);
  }
}

class Exponential extends Functor {
  public float value(float x) {
    return exp(x);
  }
  public float slope(float x) {
    return exp(x);
  }
}

class Cotangent extends Functor {
  public float value(float x) {
    return cos(x)/sin(x);
  }
  public float slope(float x) {
    return -1/(sin(x)*sin(x));
  }
}

class Cosecant extends Functor {
  public float value(float x) {
    return 1/sin(x);
  }
  public float slope(float x) {
    return -cos(x)/(sin(x)*sin(x));
  }
}
