
float xo=-500;
float yo=-500;
int d = 20;
float moveSpeed = 10;
PImage map;
PImage images[];
PImage imagesP[];
PShader blur;

import java.awt.Robot;
Cursor cursor;
float posX;
float posY;

int imgNum = 0;
int imgNumP = 0;

boolean pLock = false;

float index;
PData [] pDT = new PData[15];
float [] px = new float [15];
float [] py = new float [15];

boolean action = false;

float pRadius= 700;
float pRadiusImage = 70;
int nbrPoints = 15;

float cursorx;
float cursory;

float xoSmooth;
float yoSmooth;


float minDistanceThreshold = 700;
boolean soundPlaying = false;

import processing.sound.*;
String[] soundNames = { "Son (1).wav", "Son (2).wav", "Son (3).wav", "Son (4).wav", "Son (14).wav","Son (5).wav", "Son (6).wav", "Son (7).wav", "Son (8).wav", "Son (9).wav", "Son (10).wav", "Son (11).wav", "Son (12).wav", "Son (13).wav",  "Son (15).wav", };

SoundFile[] sounds = new SoundFile[soundNames.length];

void setup() {

  noCursor();

  fullScreen(P2D);
  blur = loadShader("blur.glsl");

  cursor = new Cursor();

  posX=width/2;
  posY=height/2;

  makeArray();
  makeArrayP();


  map = loadImage("ChaMap.jpg");
  map.resize(width*4, 0);
  for (int i=0; i<soundNames.length; i++) {
    String soundName = soundNames[i];
    sounds[i] = new SoundFile(this, soundName);
    sounds[i].amp(0);
  }


  for (int i = 0; i < pDT.length; i++) {
    pDT[i] = new PData();
  }

  for (int i = 0; i < nbrPoints; i++) {
    // Initialize px and py with random positions that are at least 700 pixels apart
    boolean positionValid = false;
    while (!positionValid) {
      px[i] = random(width / 2, (width * 4) - (width / 2));
      py[i] = random(height / 2, (height * 4) + 1000);

      // Check the minimum distance from all other points
      positionValid = true;
      for (int j = 0; j < i; j++) {
        float distance = dist(px[i], py[i], px[j], py[j]);
        if (distance < 1200) {
          positionValid = false;
          break;
        }
      }
    }
  }
}

void draw() {


  randomiseImg();


  float cursorx = width/2;
  float cursory = height/2;


  background(0);

  cursor.update(int(getLocationOnScreen().x), int(getLocationOnScreen().y));
  cursor.display();



  textSize(20);

  fill(255);

  push();

  translate (xo, yo);
  image(map, 0, 0);
  noStroke();

  //for (int i =0; i<pDT.length; i++) {
  //  pDT[i].draw(px[i], py[i]);
  //}

  for (int i = 0; i < pDT.length; i++) {
    pDT[i].draw(px[i], py[i]);

    // Calculate the distance from the cursor to the point
    float distance = dist(cursorx - xo, cursory - yo, px[i], py[i]);

    if (distance < pRadius) {
      // Calculate the volume based on distance (inverse proportion)
      float volume = map(distance, 0, pRadius, 1.0, 0.0);
      sounds[i].amp(volume); // Set the sound file's volume
      if (!soundPlaying) {
        sounds[i].loop(); // Start playing the sound
        soundPlaying = true;
      }
    }
  }

  // Check if no points are within the threshold, and stop the sound
  boolean stopSound = true;
  for (int i = 0; i < nbrPoints; i++) {
    float distance = dist(cursorx - xo, cursory - yo, px[i], py[i]);
    if (distance < minDistanceThreshold) {
      stopSound = false;
      break; // Exit the loop as soon as one point is within threshold
    }
  }

  if (stopSound && soundPlaying) {
    for (int i = 0; i < nbrPoints; i++) {
      sounds[i].stop();
    }// Stop playing the sound
    soundPlaying = false;
  }

  pop();

  textSize(20);
  fill(255);

  text(xo, width/2 + 30, height/2-30);
  text(yo, width/2 + 30, height/2 -50);

  for (int i = 0; i < nbrPoints; i++) {
    float distance = dist(cursorx - xo, cursory - yo, px[i], py[i]);


    if (distance < pRadiusImage) {
      //lendMode(LIGHTEST);
      if (pLock == false) {
        randomiseImgP();
        pLock = true;
      }

      blur.set("textureDif", images[imgNum]);
      filter(blur);


      blur.set("textureDif", imagesP[i]);

      filter(blur);

      //image(images[imgNum], 0, 0);
      //image(imagesP[i], 0, 0);
    }
    if (distance > pRadiusImage) {
      blendMode(BLEND);
      pLock = false;
    }
  }






  rectMode(CENTER);
  fill(255);
  noStroke();
  rect(cursorx, cursory, 50, 5);
  rect(cursorx, cursory, 5, 50);

  noFill();
  strokeWeight(3);
  stroke(255);


  mapConstraint();
  move();
  mapConstraint();
  //movement();
}

//void movement() {


//  if (mouseX < 400) {
//    xo = xo +moveSpeed;
//  }

//  if (mouseX > 1600) {
//    xo = xo -moveSpeed;
//  }

//  if (mouseY < 200) {
//    yo = yo +moveSpeed;
//  }

//  if (mouseY > 800) {
//    yo = yo -moveSpeed;
//  }

//  if (yo + xo > 21) {

//    yo=moveSpeed/2;
//    xo=moveSpeed/2;
//  }
//}

void makeArrayP() {
  // Get the path to the "data" folder
  String dataPath = sketchPath("dataP");
  // List all files in the "data" folder
  File[] files = listFiles(dataPath);
  // Initialize the images array
  imagesP = new PImage[files.length];
  // Loop through the files and load images
  for (int i = 0; i < files.length; i++) {
    // Check if the file has a valid image extension
    if (isImageFile(files[i])) {
      // Load the image and store it in the array
      imagesP[i] = loadImage(files[i].getAbsolutePath());
      imagesP[i].resize(width, 0);
      blur.set("textureDif", imagesP[i]);
    }
  }
  // Now you have all the loaded images in the "images" array
  // You can access them using indices like images[0], images[1], etc.
}
// Function to check if a file has a valid image extension
boolean isImageFileP(File file) {
  String[] extensions = {".jpeg", ".JPEG"};
  String filename = file.getName().toLowerCase();
  for (String ext : extensions) {
    if (filename.endsWith(ext)) {
      return true;
    }
  }
  return false;
}

void makeArray() {
  // Get the path to the "data" folder
  String dataPath = sketchPath("dataM");
  // List all files in the "data" folder
  File[] files = listFiles(dataPath);
  // Initialize the images array
  images = new PImage[files.length];
  // Loop through the files and load images
  for (int i = 0; i < files.length; i++) {
    // Check if the file has a valid image extension
    if (isImageFile(files[i])) {
      // Load the image and store it in the array
      images[i] = loadImage(files[i].getAbsolutePath());
      images[i].resize(width, 0);
      blur.set("textureDif", images[i]);
    }
  }
  // Now you have all the loaded images in the "images" array
  // You can access them using indices like images[0], images[1], etc.
}
// Function to check if a file has a valid image extension
boolean isImageFile(File file) {
  String[] extensions = {".jpg", ".JPG"};
  String filename = file.getName().toLowerCase();
  for (String ext : extensions) {
    if (filename.endsWith(ext)) {
      return true;
    }
  }
  return false;
}

void randomiseImg() {
  // Generate a random index to select an image from the "images" array
  if (frameCount % 10==0) {
    imgNum = (int)random(0, (images.length));
  }
}

void randomiseImgP() {
  // Generate a random index to select an image from the "images" array
  imgNumP = (int)random(0, (imagesP.length));
}


void mapConstraint() {
  if (xo>0 ) {
    xo=0;
  }
  if (xo<-5600) {
    xo=-5600;
  }
  if (yo <-3100) {
    yo = -3100;
  }
  if (yo>0 ) {
    yo=0;
  }
}

//version mac

//void mapConstraint() {
//  if (xo>0 ) {
//    xo=0;
//  }
//  if (xo<-7500) {
//    xo=-7500;
//  }
//  if (yo <-4000) {
//    yo = -4000;
//  }
//  if (yo>0 ) {
//    yo=0;
//  }
//}



void move() {

  posX = mouseX-width/2;
  posY = mouseY-height/2;




  xoSmooth-=posX*0.4;
  yoSmooth-=posY*0.4  ;



  xo -= (xo-xoSmooth)*0.1;


  yo -= (yo-yoSmooth)*0.1;
}
