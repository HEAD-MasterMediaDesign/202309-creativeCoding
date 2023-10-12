class Ball{

  float x;
  float y;
  float cardWidth;
  float cardHeigth; 
 
  
  //contructeur / call 1 time
  void Card(float _x,float _y, float _width, float _height){
    x = _x;
    y = _y;
    cardWidth = _width;
    cardHeigth = _height;
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
