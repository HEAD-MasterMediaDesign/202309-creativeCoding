class Cursor {
  Robot robot;

  Cursor() {
    try {
      robot = new Robot();
    }
    catch (Throwable e) {
    }
  }

  void update(int xFrame, int yFrame) {
    robot.mouseMove(xFrame+round(width/2), yFrame+round(height/2));
  }

  void display()
  {
    ellipse(mouseX, mouseY, 10, 10);
  }
}


PVector getLocationOnScreen() {
  PVector location = new PVector();
  // JAVA2D
  if (surface instanceof processing.awt.PSurfaceAWT) {
    java.awt.Frame frame = ( (processing.awt.PSurfaceAWT.SmoothCanvas) ((processing.awt.PSurfaceAWT)surface).getNative()).getFrame();
    java.awt.Point point = frame.getLocationOnScreen();
    location.set(point.x, point.y);
  }
  // P2D, P3D
  else if (surface instanceof processing.opengl.PSurfaceJOGL) {
    com.jogamp.newt.opengl.GLWindow window = (com.jogamp.newt.opengl.GLWindow)(((PSurfaceJOGL)surface).getNative());
    com.jogamp.nativewindow.util.Point point = window.getLocationOnScreen(new com.jogamp.nativewindow.util.Point());
    location.set(point.getX(), point.getY());
  }
  return location;
}
