void setup(){
  size(800,800,P2D);
  background(30);
}

float ang=0;

void draw(){
  ang=ang+0.01;
  noStroke();
  fill(0,4);
  rectMode(CORNER);
  rect(0,0,width,height);
  
  push();
  translate(width/2,height/2);
  rectMode(CENTER);
  
  rotate(ang);
  
  fill(255,255,0);
  rect(0,0,400,50);
  
  rotate(ang*2);
  
  fill(255,0,0);
  rect(0,0,40,200);
  
  rectMode(CORNER);
  fill(0,0,255);
  
  rect(0,0,700,20);
  
  
  
  pop();
}
