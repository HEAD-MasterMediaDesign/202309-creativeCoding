PImage[] images = new PImage[3];



void setup() {
  size(500, 500);
  background(255);

  frameRate(3);

  images[0] = loadImage("bob0.jpg");
  images[1] = loadImage("bob1.png");
  images[2] = loadImage("bob2.jpg");
}

void draw() {

  for(int i = 0; i < images.length; i++) {

    PImage imageData = images[i];

    int imageWidth = int(random(50, 100));

    image(
      images[i],
      i * 30,
      100 * i,
      imageWidth,
      imageWidth * imageData.height / imageData.width
    );
  }

}
