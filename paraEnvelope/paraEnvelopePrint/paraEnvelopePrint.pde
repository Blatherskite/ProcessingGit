import processing.pdf.*; //<>//
float minX = -4;
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 10;
float stepSize = .01;
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
//    size(2000, 2000);
    size(4000, 4000, PDF, "Envelope.pdf");
  parabola.setFrame(minX, maxX, minY, maxY);
  cubic.setFrame(minX, maxX, minY, maxY);
  sine.setFrame(minX, maxX, minY, maxY);
  exponential.setFrame(minX, maxX, minY, maxY);
  cotangent.setFrame(minX, maxX, minY, maxY);
  cosecant.setFrame(minX, maxX, minY, maxY);
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
  stroke(0, 255*stepSize+10);
  float range = 6;
  for (int i = 0; i < range / stepSize; ++i) {
    float x_ = -3 + i * stepSize;
    float slope = functor.slope(x_);
    float y = functor.value(x_);
    line(mapXToScreen(x_-dX, functor.minX, functor.maxX), mapYToScreen(-slope*dX+y, functor.minY, functor.maxY), mapXToScreen(x_+dX, functor.minX, functor.maxX), mapYToScreen(slope*dX+y, functor.minY, functor.maxY));
  }
  exit();
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
//  println(newMinX);
  minX = newMinX;
  maxX = newMaxX;
  minY = newMinY;
  maxY = newMaxY;
  functor.setFrame(minX, maxX, minY, maxY);
}

void setStepSize(float d) {
  stepSize = d;
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

float mapXToScreen(float x, float minX, float maxX) {
  return (x - minX)/(maxX - minX)* width - width/2;
}

float mapYToScreen(float y, float minY, float maxY) {
  return height/2 -(y - minY)/(maxY - minY)* height;
  
}
abstract class Functor {
  float minX, minY, maxX, maxY;
  abstract float value(float x);
  abstract float slope(float x);
  void setFrame(float minX_, float maxX_, float minY_, float maxY_) {
    minX = minX_;
    maxX = maxX_;
    minY = minY_;
    maxY = maxY_;
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
