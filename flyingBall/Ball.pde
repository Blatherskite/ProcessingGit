class Ball {
  float diameter = 20;
  float strokewidth = 3;
  float x, y;
  float vx, vy;
  float ay;
  
  Ball() {
    x = 0;
    y = 0;
    vx = 7;
    vy = 0;
    ay = .2;
  }
  
  void draw() {
    stroke(strokewidth);
    fill(0);
    ellipse(x, y, diameter, diameter);
    x += vx;
    y += vy;
    vy += ay;
  }
}
