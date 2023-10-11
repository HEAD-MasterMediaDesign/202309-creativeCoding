void setup() {
  size(800, 800, P2D);
  //fullScreen(P2D);
}

float tx=0;
float ty=0;
float scale=0.01;
float time=0;
void draw() {
  background(20);
  noiseDetail(16);
  
  int resolution=6;

  for (int i=0; i<width; i+=resolution) {
    for (int j=0; j<height; j+=resolution) {

      float val = noise(i*scale+tx,j*scale+ty,time);
      float col=map(val, 0, 1, 0, 255);
      
      fill(col);
      noStroke();
      rect(i, j, resolution, resolution);
    }
  }
  scale=map(mouseX,0,width,0,0.1);
  
  tx+=0.01;
  //ty+=0.01;
  time+=0.005;
}
