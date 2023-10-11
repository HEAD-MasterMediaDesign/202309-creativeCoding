class Montagnes {
  //these array will load and contain all the images
  PImage[] imgMontagne;
  PImage[] mskMontagne;
  PImage[] imgTrash;

  boolean running;
  int indexTrash;
  int index;
  float imgRatio;
  int time;

  //create a PGraphics layer (layer(calques) like in photoshop) to draw the mountain seperatly from the rest of the sketch
  PGraphics PGMontagne;
  int canvasWidth   = 50;
  int canvasHeight  = 50;

  //those variables will be used to pass the images names from the main "postCard" to the Montagne constructor
  Montagnes(String[] imageMontagneNames, String[] imgTrashNames, String[] mskMontagneNames, int _canvasWidth, int _canvasHeight) {
    this.canvasWidth = _canvasWidth;
    this.canvasHeight = _canvasHeight;

    // initialize the PGraphics layer size with the canvasWidth and canvasHeight
    this.PGMontagne = createGraphics(this.canvasWidth, this.canvasHeight, P2D);

    // initialize global variables, "this." is used to refer to the global variables of the Montagne class
    this.imgTrash = new PImage[imgTrashNames.length];
    this.indexTrash = 0;
    this.time = 0;
    this.imgMontagne = new PImage[imageMontagneNames.length];
    this.running = false;
    this.mskMontagne = new PImage[mskMontagneNames.length];

    // load mountain and trash images from the imageMontagneNames imgTrashNames arrays
    for (int i = 0; i < imageMontagneNames.length; i++) {
      this.imgMontagne[i] = loadImage(imageMontagneNames[i]);
      this.imgMontagne[i].resize(width, height);
      this.imgMontagne[i].filter(BLUR, 3);
      this.imgMontagne[i].loadPixels();
      //this.imgMontagne[i].filter(-THRESHOLD);
    }

    for (int j = 0; j < imgTrashNames.length; j++) {
      this.imgTrash[j] = loadImage(imgTrashNames[j]);
      this.imgTrash[j].resize(width, height);
      this.imgTrash[j].loadPixels();
      
    }

    for (int k = 0; k < mskMontagneNames.length; k++) {
      this.mskMontagne[k] = loadImage(mskMontagneNames[k]);
      this.mskMontagne[k].resize(width, height);
       this.mskMontagne[k].loadPixels();
    }
    index = int(random(this.imgMontagne.length));


    // calculate the ratio of the Moutain image
    int imageWith = this.imgMontagne[index].width;
    int imageHeight = this.imgMontagne[index].height;
    this.imgRatio = float(imageWith) / float(imageHeight);

    drawMountain();
  }

  void update() {

    // start drawing the mountain
    PGMontagne.beginDraw();
    PGMontagne.push();
    //PGMontagne.background(255, 255, 255);


    //draw moutain into the PGraphics layer
    if (time == 1) {
      //this.imgMontagne[index].mask(this.mskMontagne[index]);
      PGMontagne.noTint();
      PGMontagne.image(imgMontagne[index], 0, 0, canvasWidth, canvasHeight);
    }

    if (time > 10 && time < 300) { // timer = quantitee de dechets

      for (int k=0; k<2; k++)
        for (int i = 0; i < 12; i++) {
          int px = int(random(imgMontagne[index].width)); // les pixel qu'on choppe
          int py = int(random(imgMontagne[index].height));

          //int colo = imgMontagne[index].get(px, py - 30);
          int colo = imgMontagne[index].pixels[py*imgMontagne[index].width+px];

          if (alpha(colo) != 0) { // FAKED OUTLINE HERE py-60
            color col = colo;
            float scal = random(75, 125);
            PGMontagne.tint(col);
            int de = int(random(imgTrash.length));

            // Apply msk using images's alpha channel
            if (alpha(colo) > 50) { // Set your threshold here
              // always wright any transformation to the image with PGMontagne. in front of it
              PGMontagne.push();
              PGMontagne.translate(px, py);
              PGMontagne.rotate(random(360));
              
              if(random(10)<1){
                PGMontagne.blendMode(BLEND); 
              }else{
                PGMontagne.blendMode(SCREEN);
              }
              
              //PGMontagne.tint(255,100);
              PGMontagne.imageMode(CENTER);
              PGMontagne.image(imgTrash[de], 0, 0, scal, scal);
              PGMontagne.pop();
            }
          }
        }
    }
    // increment the timer
    time++;
    // end drawing the mountain
    PGMontagne.pop();
    PGMontagne.endDraw();
  }

  private void drawMountain() {
    // draw the PGraphics layer on the main sketch
    index = int(random(this.imgMontagne.length));
    this.PGMontagne.beginDraw();
    this.PGMontagne.noTint();
    this.PGMontagne.imageMode(CORNER);
    this.PGMontagne.image(imgMontagne[index], 0, 0, canvasWidth, canvasHeight);

    this.PGMontagne.endDraw();
  }

  void clearCanvas() {
    // clearthe PGraphics layer
    this.time = 0;
    this.PGMontagne.beginDraw();
    this.PGMontagne.clear();
    this.PGMontagne.endDraw();
    this.drawMountain();
  }

  PImage imgIndex() {
    PImage imgMsk = this.mskMontagne[index];

    return imgMsk;
  }
}
