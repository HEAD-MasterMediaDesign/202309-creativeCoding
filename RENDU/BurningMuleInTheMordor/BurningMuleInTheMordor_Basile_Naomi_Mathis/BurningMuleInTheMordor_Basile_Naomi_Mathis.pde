//----------OPEN AUDIO BEFORE PLAYING
//----------HAVE FUN DISCOVERING WEIRD CREATURES FROM CHAMONIX THAT ARE HIDDING IN THE SOUND
//----------RED SQUARE IS FOR DEBBUG PURPOSES

//importFonts______
PFont typo;

//importing and setting up minim________________
import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.*;
Minim m;

//setting up time duration____________
int duration = 60*1000; //1minute
int setupChangeTime = 0;
int currentSetup = 1;

//setting up the images and backgrounds________________
PImage img1;
PImage img2;

PImage currentImage;

//maskNoir
PGraphics black;
PGraphics mask;
PImage maskImage;
PImage maskImageInv;

//setting up the zoom___________
float zoom = 7.0;
float zoomSmooth= 1.0;
PVector zoomCenter;

//setting up audio players____________________
AudioPlayer [] s1 = new AudioPlayer[5];
AudioPlayer [] s2 = new AudioPlayer[5];
AudioPlayer [] s3 = new AudioPlayer[5];


AudioPlayer ambiSound;
AudioPlayer noiseSound;

//setting up basics trigger boxes________________
int[][] boites = {
  {511, 611, 492, 592},
  {741, 841, 520, 620},
  {935, 1035, 372, 472},
  //{1080, 1180, 650, 750},
};

//for detect play __________________________
boolean isPlaying = true;
boolean isZoomed = false;

//GLITCH SETUP___________________
float x, y;
float yStep = random(5, 10);
float xStep = random(250, 300);
float a, a_;
int num = 400;
boolean isglitch = false;

//SETUP_________________________________
void setup() {

  typo = loadFont("PTMono-Regular-48.vlw");

  //size(1000, 1000, P2D);
  fullScreen(P2D);
  background(0);
  frameRate(30);

  m = new Minim(this);


  //BACKGROUNDS  ____________________
  img1 = loadImage("data/img/img04.jpg");
  img1.resize(width, height);

  img2= loadImage("data/img/img03.JPG");
  img2.resize(width, height);

  loadPixels();
  img1.loadPixels();
  img2.loadPixels();


  maskImage = loadImage("mask.png");
  maskImage.resize(400, 400);
  maskImageInv = loadImage("maskinv.png");
  maskImageInv.resize(200, 200);

  black = createGraphics(width, height, P2D);
  black.beginDraw();
  black.background(0);
  black.endDraw();

  mask = createGraphics(width, height, P2D);
  mask.beginDraw();
  mask.background(0);
  mask.endDraw();

  //SOUND PLAYLIST & LOADING _______________________________
  loadSounds1();

  noiseSound = m.loadFile("noise.mp3");
  ambiSound = m.loadFile("ambient.mp3");
  ambiSound.play();
}

//to make an audio play once and never again -> s1.close();
// faire des dossiers dossier/fichier_i.qqch

// DRAW______________________________
void draw() {

  noCursor();

  background(0);
  zoom1();

  trigBoxes();
  mousePosition();
  audioTrigger();



  println(frameCount);
}

//DETECT & PLAY AUDIO___________________
void detectPlay (AudioPlayer [] s, int[] box, int[] counters) {


  int minX = int(box[0] * zoom);
  int maxX = int(box[1] * zoom);
  int minY = int(box[2] * zoom);
  int maxY = int(box[3] * zoom);

  boolean mouseWithinRange = (mouseX >= minX && mouseX <= maxX && mouseY >= minY&& mouseY <= maxY);

  int indexAudio = counters[0] % 5;

  if (mouseWithinRange && !s[indexAudio].isPlaying()) {
    //ambiSound.pause();
    s[indexAudio].play();
    isPlaying = true;
  } else if (!mouseWithinRange && s[indexAudio].isPlaying()) {
    //ambiSound.loop();
    s[indexAudio].pause();
    counters[0]++;

    if (counters[0]>=5) {
      counters[0] =5;
    }

    isPlaying = false;
    s[indexAudio].rewind();
  }
}
