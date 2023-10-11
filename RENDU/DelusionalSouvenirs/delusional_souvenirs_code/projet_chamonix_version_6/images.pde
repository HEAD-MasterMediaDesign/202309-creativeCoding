import processing.sound.*;
class Image {

  SoundFile sample;
  Amplitude rms;


  PGraphics pgParent;
  PImage[] images = new PImage[39];
  boolean rectoImage = false;
  int randomIndexImage = 0;
  PImage currentImage;

  int i = height;
  //transparence variable
  float alpha = 255;

  int frameCounter = 0;

  Image(PGraphics _pgParent) {
    images[0] = loadImage("1.jpg");
    images[1] = loadImage("2.jpg");
    images[2] = loadImage("3.jpg");
    images[3] = loadImage("4.jpg");
    images[4] = loadImage("5.jpg");
    images[5] = loadImage("6.jpg");
    images[6] = loadImage("7.jpg");
    images[7] = loadImage("8.jpg");
    images[8] = loadImage("9.jpg");
    images[9] = loadImage("10.jpg");
    images[10] = loadImage("11.jpg");
    images[11] = loadImage("12.jpg");
    images[12] = loadImage("13.jpg");
    images[13] = loadImage("14.jpg");
    images[14] = loadImage("15.jpg");
    images[15] = loadImage("16.jpg");
    images[16] = loadImage("17.jpg");
    images[17] = loadImage("18.jpg");
    images[18] = loadImage("19.jpg");
    images[19] = loadImage("20.jpg");
    images[20] = loadImage("21.jpg");
    images[21] = loadImage("22.jpg");
    images[22] = loadImage("23.jpg");
    images[23] = loadImage("24.jpg");
    images[24] = loadImage("25.jpg");
    images[25] = loadImage("26.jpg");
    images[26] = loadImage("27.jpg");
    images[27] = loadImage("28.jpg");
    images[28] = loadImage("29.jpg");
    images[29] = loadImage("30.jpg");
    images[30] = loadImage("31.jpg");
    images[31] = loadImage("32.jpg");
    images[32] = loadImage("33.jpg");
    images[33] = loadImage("34.jpg");
    images[34] = loadImage("35.jpg");
    images[35] = loadImage("36.jpg");
    images[36] = loadImage("37.jpg");
    images[37] = loadImage("38.jpg");
    images[38] = loadImage("39.jpg");
    randomIndexImage = int (random(images.length));
    currentImage = images[randomIndexImage];

    pgParent = _pgParent;

    sample = new SoundFile(parent, "4min.mp3");

    rms = new Amplitude(parent);
  }

  void draw() {
    //random image
    pgParent.imageMode(CORNER);
    if (this.frameCounter == 0) {
      pgParent.image(currentImage, 0, 0, 900, 600);
      sample.stop();
    }

    if (rectoImage == true) {
      // println(rms.analyze());

      //fabrication des lignes
      float x = random(5, 900);
      int newX = int(x);
      float y = random(i, 600);
      int newY = int(y);
      float lineHeight = random(300);
      //int newLineHeight = int(lineHeight);
      color c = pgParent.get(newX, newY);

      //map du son à la largeur des rectangles
      float largeur = map (rms.analyze(), 0, 1, 1, 50);
      println (rms.analyze());
      //lignes
      pgParent.strokeWeight (largeur);
      pgParent.strokeCap(SQUARE);
      pgParent.stroke(c, random(alpha));
      pgParent.line(x, y, x, y+lineHeight);
      i = i-1;
      if (i<5) {
        i=5;
      }
      alpha = alpha - 0.2;
      if (alpha < 50) {
        alpha =50;
      }
      if (largeur <0) {
        largeur = largeur*-1;
      }
    }

    frameCounter++;
  }
}
