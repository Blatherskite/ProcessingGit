ArrayList<Ball> balls;
int numberFramesPerBall = 10;
int numberFramesToSkipBeforeRecoring = 100;

void setup() {
 size(500,500);
 balls = new ArrayList<Ball>();
}

void draw() {
  //if(frameCount >= numberFramesToSkipBeforeRecoring + numberFramesPerBall) {
    //return;
  //}
  
  background(255);
  text("fps="+((int) frameCount ), width-100, 20);
  
  if (frameCount % numberFramesPerBall == 0) {
  balls.add(new Ball());
  }
  for(Ball aBall: balls) {
    aBall.draw();
  }
  //saveFrame("flyingBallGif-###.png");
}
