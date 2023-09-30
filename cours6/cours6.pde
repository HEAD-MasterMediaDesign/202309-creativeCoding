///// PRIMITIF
float number = 9.9;
int numberInteger = 8;
char oneCarac = 'a'; //juste one caract
boolean flag = true;
boolean otherFlag = false;
///// OBJECTS
String tab = "abcdefghijklmnopqrstuvwxyz01234567890(é&-vnksdfslkdnfslkABCDEFGHIJKLMNOPRSTUVWXYZ";
String otherSentence = "Hello World !";
PImage onePicture;
PFont oneFont;

void setup() {
  size(600, 600);
  background(100);
  frameRate(1);
}

void draw() {
  background(50);

  for (int i=0; i<width; i+=10) {
    for (int j=0; j<height; j+=10) {
      fill(random(150, 255), random(150, 255), random(150, 255));
      noStroke();
      
      float de = random(tab.length());
      int index = int(de);
      //stroke(random(150, 255));
      //ellipse(i,j, 10, 10);
      text(tab.charAt(index), i, j);
    }
  }
}
