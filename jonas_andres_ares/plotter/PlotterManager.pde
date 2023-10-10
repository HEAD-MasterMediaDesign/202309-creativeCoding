import processing.svg.*;
import java.lang.reflect.Method;

class PlotterManager {
  OscBridge oscBrigde;
  Object parent;
  boolean plotterBusy = false;
  int drawCount = 0;

  PlotterManager(Object parent){
    this.parent = parent;
    oscBrigde = new OscBridge(1000, 2000, this);
  }

  void draw(){
    if(!plotterBusy){
      beginRecord(SVG, "draw-####.svg");

      if(drawCount == 0){
        callSetupPlotter();
      } else {
        callDrawPlotter();
      }

      endRecord();

      plotterBusy = true;
      drawCount++;
    }
  }

  private void callSetupPlotter(){
    try {
      Class parentClass =  parent.getClass();
      Method method = parent.getClass().getMethod("setupPlotter");
      method.invoke(parent);
    }
    catch (Exception e) {
      // no such method, or an error...
      println("Calling drawPlotter failed");
      e.printStackTrace();
    }
  }

  private void callDrawPlotter(){
    try {
      Class parentClass =  parent.getClass();
      Method method = parent.getClass().getMethod("drawPlotter");
      method.invoke(parent);
    }
    catch (Exception e) {
      // no such method, or an error...
      println("Calling drawPlotter failed");
      e.printStackTrace();
    }
  }

  private void callSetPointList(ArrayList<PVector> pointList){
    try {
      Class parentClass =  parent.getClass();
      Method method = parent.getClass().getMethod("setPointList", ArrayList.class);
      method.invoke(parent, pointList);
    }
    catch (Exception e) {
      // no such method, or an error.. 
      println("Calling oscEvent failed");
      e.printStackTrace();
    }

  }

  void oscEvent(String eventName, OscMessage msg){
    println("Plotter Manager: Received osc event:", eventName);
    println("length", msg.arguments().length);
    if(eventName.equals("drawing-complete")){
      plotterBusy = false;
    }
   
    if(eventName.equals("points-straight")){
      ArrayList<PVector> pointList = new ArrayList<PVector>();
      for (int i = 0; i < msg.arguments().length; i += 2) {
          float x = msg.get(i).floatValue();
          float y = msg.get(i + 1).floatValue();
          println("Point: (" + x + ", " + y + ")");
          pointList.add(new PVector(x, y));
      }
      callSetPointList(pointList);
    }
    
  }
}