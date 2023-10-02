void setup(){
  size(800,800,P3D);
  bob = loadImage("bob.png");
}
PImage bob;
float ang=0;
float angB=0;

void draw(){
  background(20);
  noStroke();
  
  push();
  //translate to center of the scene
  translate(width/2,height/2);
  
  rotateY(ang);
  //go for the sun
  fill(255,255,0);
  box(100);
  
  //got for the earth, translate from sun
  rotateY(angB);
  translate(200,0);
  fill(0,100,240);
  sphere(30);
  
  //go for the moon
  rotateY(angB);
  translate(70,0);
  fill(200);
  sphere(20);
  
  pop();
  ang=ang+0.01;
  angB+=0.01;
}
