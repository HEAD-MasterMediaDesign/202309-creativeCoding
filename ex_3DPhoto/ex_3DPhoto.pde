
import peasy.PeasyCam;


PeasyCam cam;

PImage extrude;
int [] [] values;
float angle = 0;

//__________________________________________

void setup() {
  size(1200, 1200, P3D);
 cam = new PeasyCam(this, 400);
 
  float s=0.6;
  extrude = loadImage("Sunlight_garden_01.png");
  extrude.resize(int(extrude.width*s), int(extrude.height*s));
  extrude.loadPixels();
  values = new int[extrude.width] [extrude.height];

  for (int y = 0; y < extrude.height; y+=3) {
    for (int x = 0; x < extrude.width; x+=3) {
      color pixel = extrude.get(x, y);
      values[x][y] = int(brightness(pixel));
    }
  }

  //hint(ENABLE_DEPTH_SORT);
  //hint(ENABLE_DEPTH_TEST);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*100.0);
}

//____________________________________________

void draw() {
  background(0);

  //imageMode(CENTER);

  angle += 0.01;
  pushMatrix();
  //translate(width/2, height/2, -208);
  rotateY(angle);
  rectMode(CENTER);
  fill(255,255,0);
  rect(0,0,100,100);
  
  translate(-width/4, -height/4, 200);

  for (int y=0; y<extrude.height; y+=6) {
    for (int x=0; x<extrude.width; x+=6) {
      //stroke(values[x][y]);
      //point(x, y, -values[x][y]);
      noStroke();
      fill(values[x][y]);
      pushMatrix();
      translate(x, y, -values[x][y]);
      rect(0, 0, 3, 3);
      popMatrix();
    }
  }
  popMatrix();
}
