class Ball{
  float x;
  float y;
  float vx;
  float vy;
  float nb;
  float str;
  char letter;
  int time=0;
  int timerMax=int(random(5,20));
  //contructeur / call 1 time
  Ball(float _x,float _y){
    x = _x;
    y = _y;
    vx = 0;
    vy = 20;
    nb = random(255);
    str = random(2,30);
    randomLetter();
  }
  
  void draw(){
    fill(0,nb,0);
    noStroke();
    //ellipse(x,y,str,str);
    //move position by speed
    textSize(16);
    text(letter,x,y);
    x += vx; // x = x + vx;
    if(time>timerMax){
      y += vy;
      randomLetter();
      time=0;
    }
    time++;
    
    if(x<0 || x>width)vx*=-1;
    if(y>height)y=-5;
  }
  void randomLetter(){
    letter = char(int(random(255)));
  }
}
