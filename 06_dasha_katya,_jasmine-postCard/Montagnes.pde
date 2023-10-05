class Montagnes {
  PImage[] imgMontagne;
  PImage[] imgTrash;
  boolean running;
  int indexTrash;
  int index;
  float imgRatio;
  int time;
  PGraphics PGMontagne;
  int canvasWidth;
  int canvasHeight;
  PGraphics pg;



  Montagnes(String[] imgMontagne, String[] imgTrash, int _canvasWidth, int _canvasHeight) {
    this.canvasWidth = _canvasWidth;
    this.canvasHeight = _canvasHeight;
    
    pg=createGraphics(50, 50);

    this.PGMontagne = createGraphics(_canvasWidth, _canvasHeight);



    // initialize global variables
    this.imgTrash = new PImage[imgTrash.length];
    this.indexTrash = 0;
    this.time = 0;
    this.imgMontagne = new PImage[imgMontagne.length];
    this.running = false;


    // load mountain and trash images from the arrays

    for (int i = 0; i < this.imgMontagne.length; i++) {
      this.imgMontagne[i] = loadImage(imgMontagne[i]);
      this.imgMontagne[i].resize(width, height);
      this.imgMontagne[i].filter(BLUR, 3);
    }

    for (int j = 0; j < this.imgTrash.length; j++) {
      this.imgTrash[j] = loadImage(imgTrash[j]);
      this.imgTrash[j].resize(width, height);
    }

    index = int(random(this.imgMontagne.length));

    // calculate the ratio of the Moutain image
    int imageWith = this.imgMontagne[index].width;
    int imageHeight = this.imgMontagne[index].height;
    this.imgRatio = float(imageWith) / float(imageHeight);
    //println(imgRatio," ratio montagne ", imgMontagne[index].width, imgMontagne[index].height);
  }

  void update() {

    PGMontagne.beginDraw();
    PGMontagne.background(100, 100);
    PGMontagne.fill(255, 0, 0);
    PGMontagne.rect(0, 0, 20, 20);

    PGMontagne.endDraw();

    PGMontagne.beginDraw();


    //draw moutain
    if (time == 3) {
      PGMontagne.image(imgMontagne[index], 0, 0, canvasWidth, canvasHeight);
    }

    if (time > 10 && time < 300) { // timer = quantitee de dechets
      println("bla bla");
      for (int i = 0; i < 15; i++) {
        int px = int(random(width)); // les pixel qu'on choppe
        int py = int(random(height));

        if (alpha(imgMontagne[index].get(px, py)) != 0) { // si alpha est 0
          color col = imgMontagne[i].get(px, py);
          float scal = random(30, 50);
          PGMontagne.tint(col);
          int de = int(random(imgTrash.length));

          // Apply mask using images's alpha channel
          if (alpha(imgMontagne[index].get(px, py)) > 50) { // Set your threshold here
            PGMontagne.push();
            PGMontagne.translate(px, py);
            PGMontagne.rotate(random(360));
            PGMontagne.blendMode(SCREEN);
            //  PGMontagne.tint(col, 127);
            PGMontagne.image(imgTrash[de], 0, 0, scal, scal);
            PGMontagne.pop();
          }
        }
      }
    }

    time++;
    PGMontagne.endDraw();
  }
}
