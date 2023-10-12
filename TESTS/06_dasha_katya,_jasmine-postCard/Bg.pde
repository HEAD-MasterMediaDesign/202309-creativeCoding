class Bg {

  // create global variables
  PImage[] textureArt;
  PImage[] textureNat;
  int currentTextureArtIndex;
  int currentTextureNatIndex;
  float imgRatio;
  float imgRatio2;
  int time;
  String [] arrColor;
  color randomColor;

  // create constructor, pass in argument the two arrays of images
  Bg(String[] textureArt, String[] textureNat) {

    // initialize global variables
    this.currentTextureArtIndex = 0;
    this.currentTextureNatIndex = 0;
    this.textureArt = new PImage[textureArt.length];
    this.textureNat = new PImage[textureNat.length];
    this.time = 0;
    this.arrColor = new String[]{"394AF7", "619AD1"};
    this.randomColor = color(unhex(arrColor[int(random(arrColor.length))]));

    // load images from the arrays
    for (int i = 0; i < textureArt.length; i++) {
      this.textureArt[i] = loadImage(textureArt[i]);
      this.textureArt[i].resize(width, height);
    }

    for (int j = 0; j < textureNat.length; j++) {
      this.textureNat[j] = loadImage(textureNat[j]);
      this.textureNat[j].resize(width, height);
    }

    // set the current texture index to a random number and set the image ratio
    currentTextureNatIndex = int(random(textureNat.length));
    // imgRatio = float(textureNat[currentTextureNatIndex].width) / float(textureNat[currentTextureNatIndex].height);
    currentTextureArtIndex = int(random(textureArt.length));
    // println(imgRatio2 = textureArt[currentTextureArtIndex].width / textureArt[currentTextureArtIndex].height + " ratio texture");
  }


  void draw() {
    tint(255, 255);
    // set the background color to a shade of blue
    background(randomColor);

    imageMode(CENTER);
    // blendMode(SCREEN); //too noisy and vibrant

    // draw the images with transparency
    tint(255, 100);
    image(textureArt[currentTextureArtIndex], width/2, height/2);
    tint(255, 100);
    image(textureNat[currentTextureNatIndex], width/2, height/2);
    println("bg printed");
  }

  // randomly change textures and bg color on click
  void mousePressed() {
    currentTextureNatIndex = int(random(textureNat.length));
    currentTextureArtIndex = int(random(textureArt.length));

    randomColor = color(unhex(arrColor[int(random(arrColor.length))]));
  }
}
