PlotterManager plotterManager;
ArrayList<PVector> pointList = null;

void setup() {
  // size(1000,800, P3D);
  fullScreen(P3D);
  plotterManager = new PlotterManager(this);
  background(222, 255, 0);
  noCursor();
}

void draw() {
  plotterManager.draw();
}

void setupPlotter(){
  


  noFill();
  strokeWeight(1);
  stroke(0);

  rect(250, 0, 600, 600);
  
}

void drawPlotter(){
  noFill();
  strokeWeight(1);
  stroke(0);

  beginShape();
  for (int i = 0; i < 8; ++i) {
    curveVertex(random(250, 250 + 600),  random(0, 600));
  }
  endShape();
}

// void drawPlotter(){
//   noFill();
//   strokeWeight(1);
//   stroke(0);

//   if(pointList != null){
//     beginShape();
//     for (int i = 0; i < pointList.size(); ++i) {
//       curveVertex(pointList.get(i).x,  pointList.get(i).y);
//     }
//     endShape();
//     pointList = null;
//   }
  
// }

void setPointList(ArrayList<PVector> list){
  println("Received pointlist" + pointList.size());
  pointList = list;
}


//   PVector lastPos = new PVector(random(width-60), random(height-60));
//   for (int i = 0; i < 5; ++i) {
//     PVector newPos = new PVector(random(width-60), random(height-60));
//     line(lastPos.x, lastPos.y, newPos.x, newPos.y);
//     lastPos = newPos;
//  }