
//MOUSE FONCTIONS ___________________________
void mousePosition() {

  textFont(typo);
  textSize(18);
  textAlign(RIGHT);
  text( mouseX + " - " + mouseY, 1500, 850);

  //MOUSE POSITION___________________________
  //line(mouseX, 20, pmouseX, 80);
  println("X :"+ mouseX + " : " + pmouseX);
  //line(20, mouseY, 80, pmouseY);
  println("Y :"+mouseY + " : " + pmouseY);
  //stroke(255);
}

void mousePressed() {

  if (mouseButton == LEFT) {

    ambiSound.pause();
    noiseSound.loop();
    zoom = 10.0;
  }
}

void mouseReleased() {

  if (mouseButton == LEFT) {
    ambiSound.loop();
    noiseSound.pause();

    zoom = 1.0;
  }
}
