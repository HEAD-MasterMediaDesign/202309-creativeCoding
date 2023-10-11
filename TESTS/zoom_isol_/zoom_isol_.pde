PImage img;
float zoom = 1.0;

void setup() {
  size(1000, 1000);
  frameRate(30);
  img = loadImage("img.jpg");
  img.loadPixels();
  img.resize(width, height);
  loadPixels();
}

void draw() {
  background(0); // Efface l'écran à chaque trame

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      int loc = int(x / zoom) + int(y / zoom) * img.width;

      float r, g, b;
      r = red(img.pixels[loc]);
      g = green(img.pixels[loc]);
      b = blue(img.pixels[loc]);

      float maxdist = 50; //regler la taille du disque
      float d = dist(x, y, mouseX, mouseY);
      float adjustbrightness = 255 * (maxdist - d) / maxdist;
      r += adjustbrightness;

      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);

      color c = color(r,g,b);
      pixels[y * width + x] = c;
    }
  }
  updatePixels();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    zoom += 0.1;
  }
}
