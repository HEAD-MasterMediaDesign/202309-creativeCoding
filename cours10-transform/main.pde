void setup() {
  size(800, 800, P2D);
  rectMode(CENTER); // pour simplifier la compréhension de transform
}

void draw() {
  noFill();
  noStroke();

  if(keyPressed) background(255);

  sun();
  planet();

}

void sun() {
  pushMatrix();
  fill(0, 255, 255);
  translate(width/2, height/2);
  rotate(radians(frameCount));
  rect(0, 0, 100, 100);
  popMatrix();
}


void planet() {
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians( - frameCount));
  translate(250, 0);
  rotate(radians(frameCount * 2));
  fill(255, 0, 0);
  rect(0, 0, 50, 50);

  // moon() a pour référentiel de transformation planet(),
  // car la fonction est appelé apres pushMatrix() et avant popMatrix()
  moon();

  popMatrix();
}

void moon() {
  pushMatrix();

  rotate(radians( frameCount) * 2);
  translate(50, 0);

  fill(255, 255, 0);
  rect(0, 0, 20, 20);

  // moon2() a pour référentiel de transformation moon(),
  // car la fonction est appelé apres pushMatrix() et avant popMatrix()
  moon2();

  popMatrix();
}


void moon2() {
  pushMatrix();

  rotate(radians( frameCount) * 2);
  translate(50, 0);

  fill(255, 255, 0);
  rect(0, 0, 20, 20);

  popMatrix();
}
