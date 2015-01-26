PGraphics mask;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(750, 750);
  drawDemoMask();
}

void draw() {
  translate(width/2, height/2);
  background(255);
  fill(0);
  ellipse(mouseX - width/2, mouseY - height/2, width/10, height/10);
  ellipse(-mouseX + width/2, -mouseY + height/2, width/10, height/10);
  fill(255);
  ellipse(mouseX - width/2, mouseY - height/2, width/15, height/15);
  ellipse(-mouseX + width/2, -mouseY + height/2, width/15, height/15);
  noFill();
  stroke(0);
  strokeWeight(.5);
  ellipse(mouseX - width/2, mouseY - height/2, width/7, height/7);
  ellipse(-mouseX + width/2, -mouseY + height/2, width/7, height/7);
  noStroke();
  maskPixels();
  //  fill(255, 0, 0);
  //  ellipse(0, 0, 200, 200);
}

void drawDemoMask() {
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(102);
  mask.noSmooth();
  mask.fill(255);
  mask.ellipse(width/2, height/2, 400, 400);
  mask.fill(0);
  mask.ellipse(width/2, height/2, 100, 100);
  mask.endDraw();
  mask.loadPixels();
}

void maskPixels() {
  loadPixels();
  int[] pxls = mask.pixels;
  for (int i = 0; i < pxls.length; ++i) {
    int maskPixel = pxls[i];
    if (maskPixel != WHITE) {
      pixels[i] = BLACK;
    }
  }
  updatePixels();
}
