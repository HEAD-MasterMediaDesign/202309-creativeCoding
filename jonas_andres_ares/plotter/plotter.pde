PlotterManager plotterManager;

void setup() {
  size(500,500, P3D);
  plotterManager = new PlotterManager(this);
}

void draw() {
  plotterManager.draw();
}

void setupPlotter(){
  noFill();
  strokeWeight(1);
  stroke(0);

  rect(10, 10, width-20, height-20);
}

void drawPlotter(){
  noFill();
  strokeWeight(1);
  stroke(0);

  beginShape();
  for (int i = 0; i < 8; ++i) {
    curveVertex(random(60, width-60),  random(60, height-60));
  }
  endShape();
}


//   PVector lastPos = new PVector(random(width-60), random(height-60));
//   for (int i = 0; i < 5; ++i) {
//     PVector newPos = new PVector(random(width-60), random(height-60));
//     line(lastPos.x, lastPos.y, newPos.x, newPos.y);
//     lastPos = newPos;
//  }