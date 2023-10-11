
import java.awt.Robot;
Cursor cursor;

float posX;
float posY;

void setup() {
  size(800, 800,P2D);
  //noCursor();
   windowTitle("floating");
  cursor = new Cursor();

  posX=width/2;
  posY=height/2;
}


void draw() {
  background(0);

  //posX += mouseX-pmouseX;
  //posY += mouseY-pmouseY;
  
  cursor.update(int(getLocationOnScreen().x), int(getLocationOnScreen().y));
  cursor.display();
  
  posX += mouseX-width/2;
  posY += mouseY-height/2;
  println(posX+"  "+posY);

  rect(posX, posY, 10, 10);
}
