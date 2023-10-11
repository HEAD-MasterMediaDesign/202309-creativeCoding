
Ball [] b = new Ball[500];

void setup(){
  size(800,800,P2D);
  //fullScreen(P2D);
  for(int i=0;i<b.length;i++){
    b[i] = new Ball(random(width),random(height));
  }
}

void draw(){
  fill(0,5);
  rect(0,0,width,height);
  
  for(int i=0;i<b.length;i++){
    b[i].draw();
  }
}
