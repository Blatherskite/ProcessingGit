int blockSideInPixels = 25;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  strokeWeight(width*.1);
  ellipse(mouseX, mouseY, width*(mouseX*.001), height*(mouseY*.001));
  alias();
}

void alias() {
  for (int y0 = 0; y0 < height; y0 += blockSideInPixels) {
    for (int x0 = 0; x0 < width; x0 += blockSideInPixels) {
      int gray = blockGrayLevel(x0, y0);
      setBlockColor(x0, y0, color(gray));
    }
  }
}

int  blockGrayLevel(int x0, int y0) {
  float graySum = 0;
  int pixelCount = 0;
  for (int y = y0; y < min (y0 + blockSideInPixels, height); ++y) {
    for (int x = x0; x < min (x0 + blockSideInPixels, width); ++x) {
      int pixelColor = get(x, y);
      graySum += (red(pixelColor)+green(pixelColor)+blue(pixelColor)) / 3;
      ++pixelCount;
    }
  }
  return (int) (graySum/pixelCount);
}

void  setBlockColor(int x0, int y0, color clr) {
  for (int y = y0; y < min (y0 + blockSideInPixels, height); ++y) {
    for (int x = x0; x < min (x0 + blockSideInPixels, width); ++x) {
      set(x, y, clr);
    }
  }
}
