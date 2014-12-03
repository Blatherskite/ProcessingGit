float minX = -4;
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 5;
float stepSize = .05;
float r = (maxX - minX) * .01;

Functor functor;
Functor parabola = new Parabola();
Functor cubic = new Cubic();
Functor exponential = new Exponential();
Functor sine = new Sine();
Functor cotangent = new Cotangent();
Functor cosecant = new Cosecant();

//void bindJavascript(JavaScript js) { //<>//
//  javascript = js;
//}
//
//JavaScript javascript;

void setup() {
  size(750, 750);
  //  size(1920, 1080);
  parabola.setFrame(minX, maxX, minY, maxY);
  cubic.setFrame(minX, maxX, minY, maxY);
  sine.setFrame(minX, maxX, minY, maxY);
  exponential.setFrame(minX, maxX, minY, maxY);
  cotangent.setFrame(minX, maxX, minY, maxY);
  cosecant.setFrame(minX, maxX, minY, maxY);
  functor = parabola;
} //<>//

void draw() {
  background(255);
  translate(width/2, height/2);
  fill(100, 0);
  beginShape();
  for (float x = minX; x < maxX; x += stepSize) {
    float y = functor.value(x);
//    float x_ = mapXToScreen(x);
//    float y_ = mapYToScreen(y);
//    vertex(x_, y_);
    float yPrime = functor.slope(x);
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

float f(float x) {
  return 1/sin(x);
}

float fPrime(float x) {
  return -cos(x)/(sin(x)*sin(x)); //<>//
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
