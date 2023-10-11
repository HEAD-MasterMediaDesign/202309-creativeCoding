PFont myTypo;
PImage bob;
String monTexte;

void setup(){
  size(700,800);
  background(0);
  myTypo = loadFont("CoreSansN67CnBold-20.vlw");
  monTexte = join(loadStrings("bob.txt"),"\n");
  bob = loadImage("bob.png");
}

void draw(){
  //background(0,0,50);
  
  textAlign(LEFT,BASELINE);
  textFont(myTypo);
  fill(255);
  text("Hello World - frame : " + frameCount,20,100);
  
  fill(255,0,255);
  text("Mouse x : " + mouseX + " - " + mouseY,20,150);
  
  //box
  noFill();
  stroke(255);
  rect(100,200,mouseX,mouseY);
  
  fill(255);
  textAlign(RIGHT,TOP);
  text(monTexte,100,200,mouseX,mouseY);
  
  image(bob,mouseX,mouseY);
}
