
Analysor s1;

void setup() {
  size(1200, 800, P2D);
  //s1 = new Analysor(this, "alto.mp3", 60);
  s1 = new Analysor(this, 60);
}


void draw() {
  background(200);
  
  s1.runAnalyse();
  s1.drawPreAnalyse(0, 0, width, 300);
  
  fill(255,0,0);
  rect(20,height/2,s1.getChannel(24)*5,200);
}
