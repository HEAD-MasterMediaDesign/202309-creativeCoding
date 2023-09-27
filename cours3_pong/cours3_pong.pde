void setup() {
  size(800, 600);
  background(232, 173, 224);
  frameRate(60);
}

void draw() {
  background(232, 173, 224);
  ball();
  raquette();
  if (posX>raqX && posX<raqX+raqWidth && posY>raqY && posY<raqY+raqHeight) {
    vitX=vitX *-1;
  }
}
//------------------------------------------
//ball
float posX=9;
float posY=30;
float vitX=4;
float vitY=1.9;

void ball() {
  ellipse(posX, posY, 30, 30);
  posX = posX+vitX;
  posY = posY+vitY;

  if (posX>width) {
    vitX = vitX * -1;
  }
  if (posX<0) {
    vitX = vitX * -1;
  }
  if (posY>height) {
    vitY = vitY * -1;
  }
  if (posY<0) {
    vitY = vitY * -1;
  }
}
//-----------------------------------------
//raquette
float raqX=40;
float raqY=0;
float raqWidth=20;
float raqHeight=100;

void raquette() {
  raqY=mouseY;
  rect(raqX, raqY, raqWidth, raqHeight);
}
