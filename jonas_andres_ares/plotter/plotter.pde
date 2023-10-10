// PlotterManager plotterManager;

OscBridge oscBrigde;

ArrayList<PVector> points = new ArrayList<PVector>();

boolean plotterBusy = false;

void setup() {
  size(800,1200, P3D);
  // plotterManager = new PlotterManager(this);

  oscBrigde = new OscBridge(1000, 2000, this);
}

void draw(){
  //println("frame "+frameCount);
  noFill();
  strokeWeight(1);
  stroke(0);

  background(0);

  fill(255);

  if(points.size()>0){
     beginRecord(SVG, "draw" + millis() + ".svg");
      beginShape();

      for (int i = 0; i < points.size(); ++i) {
        vertex(points.get(i).x, points.get(i).y);
        println(points.get(i).x +"  -  "+ points.get(i).y);
      }
      endShape();
      endRecord();

      points.clear();
  }
 

  // for(int i=0;i<console.size();i++){
  //   text(console.get(i),20,i*20);
  //   println(console.get(i));
  // }

  // if(console.size()>30){
  //   console.remove(0);
  // }

}

// ArrayList<String> console = new ArrayList<String>();


void oscEvent(String eventName, OscMessage msg){
    
   println("Plotter: Received osc event:" + eventName);
    println("length" + msg.arguments().length);

    if(eventName.equals("points-straight")){
      
      
      for (int i = 0; i < msg.arguments().length; i += 2) {
          float x = msg.get(i).floatValue();
          float y = msg.get(i + 1).floatValue();
          println("Point: (" + x + ", " + y + ")");
          points.add(new PVector(x, y));
      }
      
    }

    

    // for (int i = 0; i < points.length; i += 2) {
    //     float x = points[i];
    //     float y = points[i + 1];
    //     System.out.println("Point: (" + x + ", " + y + ")");
    //  }

    // beginShape();
    // vertex(120, 80);
    // vertex(340, 80);
    // vertex(340, 300);
    // vertex(120, 300);
    // endShape(CLOSE);
}

// void draw() {
//   plotterManager.draw();
// }

// void setupPlotter(){
//   noFill();
//   strokeWeight(1);
//   stroke(0);

//   rect(10, 10, width-20, height-20);
// }

// void drawPlotter(){
//   noFill();
//   strokeWeight(1);
//   stroke(0);

//   beginShape();
//   for (int i = 0; i < 8; ++i) {
//     curveVertex(random(60, width-60),  random(60, height-60));
//   }
//   endShape();
// }


//   PVector lastPos = new PVector(random(width-60), random(height-60));
//   for (int i = 0; i < 5; ++i) {
//     PVector newPos = new PVector(random(width-60), random(height-60));
//     line(lastPos.x, lastPos.y, newPos.x, newPos.y);
//     lastPos = newPos;
//  }