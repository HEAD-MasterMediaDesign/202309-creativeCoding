PImage bob;
float ang=0;
float angB=0;

void setup(){
  size(800,800,P3D);
  bob = loadImage("bob.png");
  hint();
}

void draw(){
  push();
  fill(0,5);
  noStroke();
  rectMode(CENTER);  
  translate(width/2,height/2,-400);
  rect(0,0,width*4,height*4);
  pop();
  
  noStroke();
  push();
  //translate to center of the scene
  translate(width/2,height/2);
  
  rotateY(ang);
  //go for the sun
	fill(255,255,0);
  sphere(200);
  
  //got for the earth, translate from sun
  rotateY(angB);
  translate(200,0);
  fill(0,100,240);
  sphere(30);
  
  //go for the moon
  rotateZ(angB*10);
  rotateX(angB);
  translate(70,0);
  fill(200);
  sphere(20);
  
  //image(bob,0,0);
  
  pop();
  ang=ang+0.01;
  angB+=0.01;
}
