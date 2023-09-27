//first function, begin of the sketch, executed one time
void setup(){
  //size of the screen
  size(800,800);
  //couleur de mon sketch
  background(200,220,255);
  //framerate -> 60 frame / second
  frameRate(60);
}

//executed everytime
void draw(){
  fill(random(255));
  noStroke();
  //rect(mouseX,mouseY,100,10);
  //fill(0,255,0);
  //rect(mouseX,mouseY+50,10,10);
  fill(random(255), 0, 0);
  rect(mouseX, mouseY, random(100), random(100));
  rect(width-mouseX, mouseY, random(100), random(100));
  rect(width-mouseX, height-mouseY, random(100), random(100));
  rect(mouseX, height-mouseY, random(100), random(100));

  strokeWeight(5);
  stroke(random(255));
  line(width/2, height/2, mouseX, mouseY);
}
