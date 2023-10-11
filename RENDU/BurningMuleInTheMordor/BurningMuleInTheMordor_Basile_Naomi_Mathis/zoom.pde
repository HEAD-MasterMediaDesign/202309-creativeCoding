
void zoom1() {

  currentImage = img2;

  //background(0); // Efface l'écran à chaque trame

  float px=map(mouseX, 0, width, 0, width*zoomSmooth);
  float py=map(mouseY, 0, height, 0, height*zoomSmooth);

  pushMatrix();
  translate(-px+mouseX, -py+mouseY);


  if (zoom >= 1.5 && (currentImage == img2 || currentImage == img1)) {
    if (currentImage == img2) {
      isglitch = true;
      isZoomed = true;
      imageMode(CORNER);
      image(img1, 0, 0, width * zoomSmooth, height * zoomSmooth);
    } else if (currentImage == img1) {
      isglitch = true;
      isZoomed = true;
      imageMode(CORNER);
      image(img2, 0, 0, width * zoomSmooth, height * zoomSmooth);
    }
  } else {
    isglitch = false;
    isZoomed = false;
    imageMode(CORNER);
    image(currentImage, 0, 0, width * zoomSmooth, height * zoomSmooth);
  }

  imageMode(CORNER);

  popMatrix();

  zoomSmooth -= (zoomSmooth-zoom)*0.4;

  mask.beginDraw();
  mask.background(255);
  mask.imageMode(CENTER);
  mask.image(maskImage, mouseX, mouseY);
  mask.endDraw();
  glitch();

  black.mask(mask);
  imageMode(CORNER);
  image(black, 0, 0);
  push();
  tint(255, 150);

  blendMode(ADD);
  imageMode(CENTER);
  image(maskImageInv, mouseX, mouseY);
  blendMode(BLEND);
  pop();
}
