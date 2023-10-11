PImage img;
float zoom = 1.0;
float zoomSmooth = 1.0;

//maskNoir
PGraphics black;
PGraphics mask;
PImage maskImage;
PImage maskImageInv;

void setup() {
  size(1000, 1000,P2D);
  frameRate(30);
  img = loadImage("img.jpg");
  img.loadPixels();
  img.resize(width, height);
  loadPixels();
  windowTitle("floating");
  
  black = createGraphics(width,height,P2D);
  black.beginDraw();
  black.background(0);
  black.endDraw();
  
  mask = createGraphics(width,height,P2D);
  mask.beginDraw();
  mask.background(0);
  mask.endDraw();
  
  maskImage = loadImage("mask.png");
  maskImageInv = loadImage("maskinv2_rouge.png");
}

void draw() {
  background(0); // Efface l'écran à chaque trame

  float px=map(mouseX,0,width,0,width*zoomSmooth);
  float py=map(mouseY,0,height,0,height*zoomSmooth);

  pushMatrix();
  translate(-px+mouseX,-py+mouseY);
  imageMode(CORNER);
  image(img,0,0,width*zoomSmooth,height*zoomSmooth);
  popMatrix();
  
  zoomSmooth -= (zoomSmooth-zoom)*0.4;
  
  mask.beginDraw();
  mask.background(255);
  mask.imageMode(CENTER);
  mask.image(maskImage,mouseX,mouseY);
  mask.endDraw();
  
  black.mask(mask);
  imageMode(CORNER);
  image(black,0,0);
  
  blendMode(DIFFERENCE);
  imageMode(CENTER);
  image(maskImageInv,mouseX,mouseY);
  blendMode(BLEND);
  
  imageMode(CORNER);
  //image(mask,0,0);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    zoom = 2.2;
  }
}

void mouseReleased(){
  if (mouseButton == LEFT) {
    zoom = 1.0;
  }
}
