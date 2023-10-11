void setup(){
  size(800,800,P2D);
}

float t=0;

void draw(){
  background(20);
  
  float val = noise(t);
  
  ellipse(width/2,height/2,val*200,val*200);
  t+=0.01;
}
