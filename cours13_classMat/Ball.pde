class Ball{

  float x;
  float y;
  float vx;
  float vy;
  float nb;
  float str;
  
  //contructeur / call 1 time
  Ball(float _x,float _y){
    x = _x;
    y = _y;
    vx = random(-1,1);
    vy = random(-1,1);
    nb = random(255);
    str = random(2,30);
  }
  
  void draw(){
    fill(nb);
    noStroke();
    ellipse(x,y,str,str);
    //move position by speed
    x += vx; // x = x + vx;
    y += vy;
    
    if(x<0 || x>width)vx*=-1;
    if(y<0 || y>height)vy*=-1;
  }
}
