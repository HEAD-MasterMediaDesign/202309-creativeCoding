//first function, begin of the sketch, executed one time
void setup() {
  //size of the screen
  size(800, 1000);
  //couleur de mon sketch
  background(200, 220, 255);
  //framerate -> 60 frame / second
  frameRate(60);
}
//executed everytime
void draw() {
  if (mousePressed==true) {
    dessinA();
  }else{
    dessinB();
  }
}

void dessinA() {
  fill(random(255));
  noStroke();
  rect(mouseX, mouseY, 100, 10);
  fill(0, 255, 0);
  rect(mouseX, mouseY+50, 10, 10);
  stroke(0, 40);
  line(mouseX, mouseY, width/2, height/2);
}

void dessinB(){
  fill(random(255));
  noStroke();
  rect(random(width),random(height),10,10);
}

//keyboard event
void keyPressed() {
  //if key is 's' then i execute this inside brackets
  if (key=='s') {
    save("save"+frameCount+".png");
  }
}
