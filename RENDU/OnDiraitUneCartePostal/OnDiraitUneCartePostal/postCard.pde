Montagnes montblanc;
Bg textures;
Tourists tourists;
Txt txt;

// those array will contain the names of the images
String[] imageMontagneNames = new String[12];
String[] mskMontagneNames = new String[12];
String[] textureArtNames = new String[10];
String[] imgTrashNames = new String[12];
String[] imgTourist = new String[9];

// this array will store if a key is pressed or not
boolean[] keys = new boolean[128];
int timerMtn = 0;
int counter = 0;
PGraphics buf;

void setup() {

  size(1850, 1250, P2D);
  //fullScreen(P2D);
  
  buf = createGraphics(width,height,P2D);

  //filling the arrays with the names of the images
  for (int i = 0; i < textureArtNames.length; i++) {
    textureArtNames[i] = "texture_art_0" + i + ".jpg";
  }

  for (int k = 0; k < imageMontagneNames.length; k++) {
    imageMontagneNames[k] = "M_0" + str(k + 1) + ".png";
  }

  for (int j = 0; j < mskMontagneNames.length; j++) {
    mskMontagneNames[j] = "M_0" + str(j + 1) + "_Mask.jpg";
  }

  for (int l = 0; l < imgTrashNames.length; l++) {
    imgTrashNames[l] = "trash_0" + str(l + 1) + ".png";
  }

  for (int m = 0; m < imgTourist.length; m++) {
    imgTourist[m] = "T_0" + str(m + 1) + ".png";
  }


  // Passing the arraysto the constructor of each classes and creating the objects
  textures = new Bg(textureArtNames, width, height);
  montblanc = new Montagnes(imageMontagneNames, imgTrashNames, mskMontagneNames, width, height);
  tourists = new Tourists(imgTourist, width, height);
  txt = new Txt(width, height);
  background(255);
}

void draw() {

  background(255, 255, 255);

  //when a key is pressed redraw the specified layer
  reDraw();

  //draw the background texture layer
  image(textures.PGBg, 0, 0);

  //mask image by calling the function imgIndex() of the montblanc object that returns the right image mask
 // rotate(3*PI/2);
  PImage mskMontblanc =  montblanc.imgIndex();
  
  
  buf.beginDraw();
  buf.image(mskMontblanc,0,0);
  buf.endDraw();
  
  //montblanc.PGMontagne.mask(mskMontblanc);
  montblanc.PGMontagne.mask(buf);
  
  imageMode(CORNER);
  //draw the mountain layer
  image(montblanc.PGMontagne, 0, 0);

  //draw the text layer
  txt.drawText();
  imageMode(CORNER);
  image(txt.PGText, 0, 0);

  //draw the tourists layer
  imageMode(CORNER);
  image(tourists.PGTourist, 0, 0);
  println(frameRate);
}

// this function is called when a key is pressed to redraw the specified layer
void reDraw() {

  //calling the update function of the montblanc object and drawing the image with the PGMontagne variable

  //background = 1
  if (keys['1'] == true) {
    textures.clearCanvas();
  } else {
    textures.draw();
  }
  //montagne = 2
  if (keys['2'] == true) {
    montblanc.clearCanvas();
  } else {
    montblanc.update();
  }
  // tourists = 3
  if (keys['3'] == true) {
    tourists.clearCanvas();
  } else {
    tourists.drawTour();
  }
  //texte = 4
  if (keys['4']) {
    txt.clearTxt();
    println(key);
  }
}

void keyPressed() {
  keys[key] = true;
  // save current card = 5
  if (key == '5') {
    save("Carte_" + counter + ".jpg");
    counter++;
  }
}



void keyReleased() {
  keys[key] = false;
}
