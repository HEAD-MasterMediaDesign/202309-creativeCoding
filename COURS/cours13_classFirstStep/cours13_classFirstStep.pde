
Ball [] b = new Ball[100];

void setup(){
  size(800,800,P2D);
  for(int i=0;i<b.length;i++){
    b[i] = new Ball(width/2,height/2);
  }
}

void draw(){
  for(int i=0;i<b.length;i++){
    b[i].draw();
  }
}
