String[] stringArray = {
  "coucou",
  "hello",
  "bonjour",
};

int[][] colorArray = {
  {255, 0, 0},
  {0, 250, 0},
  {0, 0, 250},
};

PFont myFont;

void setup() {
  size(500, 500);
  background(255);

  myFont = loadFont("Avenir-Heavy-50.vlw");

  frameRate(3);
}

void draw() {
  int nombreDeI = stringArray.length;

  textFont(myFont);
  textSize(50);

  for(int i = 0; i < nombreDeI; i++) {
    fill(
      colorArray[i][0],
      colorArray[i][1],
      colorArray[i][2]
    );

    text(
      stringArray[i],
      random(width),
      random(height)
    );

  }

  if(frameCount % 9 == 0) background(255);
}
