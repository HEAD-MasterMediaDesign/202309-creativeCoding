String[] imageNames = new String[17];
Montagnes montblanc;
Bg textures;
Txt txt;
String[] textureArtNames = new String[7];
String[] textureNatNames = new String[5];
String[] imgTrash = new String[19];




void setup() {

  
  
  size(740, 520, P2D);


  // Initialize the images names
  for (int i = 0; i < textureArtNames.length; i++) {
    textureArtNames[i] = "texture_art_0" + i + ".jpg";
  }

  for (int j = 0; j < textureNatNames.length; j++) {
    textureNatNames[j] = "texture_nat_0" + j + ".jpg";
  }

  for (int k = 0; k < imageNames.length; k++) {
    imageNames[k] = "M_0" + str(k + 1) + ".png";
  }

  for (int l = 0; l < imgTrash.length; l++) {
    imgTrash[l] = "trash_0" + str(l + 1) + ".png";
  }

  // Initialize the objects with the images names
  textures = new Bg(textureArtNames, textureNatNames);
  montblanc = new Montagnes(imageNames, imgTrash,width,height);
  txt = new Txt();
  background(255);

  push();
  //textures.draw();
  //textures.mousePressed();
  pop();
  
//  txt.draw();

}

void draw() {


  image(montblanc.pg,9,30);
  montblanc.update();
  image(montblanc.PGMontagne,montblanc.canvasWidth, montblanc.canvasHeight);
  
  //txt.draw();

}
