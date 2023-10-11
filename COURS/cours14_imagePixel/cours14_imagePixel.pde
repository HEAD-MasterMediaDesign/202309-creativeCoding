PImage img;
PImage bob;

void setup() {
  size(1000, 800, P2D);
  //img = loadImage("lunarModule.jpg");
  img = loadImage("kazakhstan-lac.jpg");
  img.resize(width, height);
  
  bob = loadImage("bob.png");
}


void draw() {
  //image(img,0,0);
  noStroke();

  for (int i=0; i<50; i++) {
    int px=int(random(width));
    int py=int(random(height));
    color col = img.get(px, py);

    //noFill();
    noStroke();
    //fill(col);
    //rect(px, py, random(10), 10);
    tint(col);
    image(bob,px, py, 50, 50);
  }
}
