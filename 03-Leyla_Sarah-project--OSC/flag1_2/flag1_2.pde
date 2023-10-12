import javax.sound.sampled.*; //<>// //<>// //<>//
import oscP5.*;
import netP5.*;

OscP5 oscP5;


//Chargement des données
String[] imageNames = { "Mer_de_glace.JPG", "Place_village.JPG", "Téléphérique.JPG", "Funfair2.JPG", "Cimetiere.JPG", "Foret.JPG", "Riviere.JPG", };
String[] audioNames = {"mer_de_glace_1.mp3", "banc_1.mp3", "telepherique1.mp3", "funfair.mp3", "cimetiere.mp3", "foret.mp3", "riviere.mp3" };
String[] wavesNames = { "ZOOM0004.WAV", "ZOOM0013.WAV", "ZOOM0015.WAV", "funfair.WAV", "cimetiere.WAV", "foret.WAV", "riviere.WAV" };
String[] spectoNames ={"spectoMerGlace.jpeg", "spectoVillage.jpg", "spectoTelepherique.jpg", "spectoFunfair.jpg", "spectoCimetiere.jpg", "spectoForet.jpg", "spectoRiviere.jpg" };

int[][] finalColorArray= {
  {color(1, 28, 38), color(156, 166, 86), color(213, 226, 242) },
  {color(191, 4, 19), color(131, 166, 3), color(221, 222, 224) },
  {color(20, 23, 22), color(200, 203, 202), color(166, 107, 73) },
  {color(247, 124, 207), color(88, 215, 53), color(251, 215, 53) },
  {color(13, 38, 1), color(147, 166, 118), color(208, 223, 242) },
  {color(34, 38, 1), color(169, 191, 4), color(183, 217, 132) },
  {color(62, 89, 2), color(166, 159, 138), color(157, 191, 122) },
};

//Initialisation variables
color dark ;
color medium ;
color bright ;

PImage img;

int [] greyArray = new int[5];
int globalPercentage;

GeoImage imgCoordonnees;
Analysor s1;
Analysor s2;

IntList colorArray = new IntList();
//int [] colorNumberArray = new int[greyArray.length];

//initialisation drapeau
int flag = 1;
boolean flagIsInit = false;


void setup() {
  noStroke();
  size(800, 800);
  // Créez un objet OscP5 et écoutez le port 3334
  oscP5 = new OscP5(this, 3334); 
}

void draw() {
  //Déclenchement drapeau
  if ( !flagIsInit ) initFlag();

  background(medium);
  noStroke();
  fond();
  wave();
}

void initFlag() {
  getCol();
  flagIsInit = true;
}

//Création du fond
void fond() {
  float lattitude = abs(imgCoordonnees.gpsLong*100 - int(imgCoordonnees.gpsLong*100));
  float longitude = abs(imgCoordonnees.gpsLat*100 - int(imgCoordonnees.gpsLat*100));
  float altitude = abs(imgCoordonnees.gpsAltitude);


  float posX = 0;
  int oldPosX =0;
  int sumCol = 0;
  int currentValue = 0;
  int moyCol = 0;
  int defColor = 0;

  s1.runAnalyse();
  //Création colonnes interdépendantes dont la largeur dépend du spectogramme (greyArray)
  for (int i = 0; i < greyArray.length; i++) {
    sumCol += greyArray[i];
  }
  for (int i = 0; i < greyArray.length; i++) {
    currentValue = greyArray[i];
    int largeur = width*currentValue/globalPercentage;
    if (i == 0)
    {
      posX = 0;
    } else {
      int previousValue = greyArray[i-1];
      posX = (width*previousValue+s1.getChannel(1)*50)/(globalPercentage+s1.getChannel(1)*50);
    }

    //Couleurs en fonction de la largeur des colonnes
    moyCol = int(sumCol/greyArray.length);
    defColor = currentValue-moyCol;
    if (defColor < -2 ) {
      fill(dark);
    } else if (defColor < 10 && defColor > -2) {
      fill(medium);
    } else {
      fill(bright);
    }
    rect((posX + oldPosX), 0, largeur, height);
    oldPosX += posX;
  }

  fill(255);
  circle(lattitude*height, longitude*width, altitude/20); //création du cercle selon la latt., la long. et l'alt.
}

//Récupération des bons fichiers selon le drapeau
void getData() {
  img = loadImage(spectoNames[flag]);
  img.loadPixels();


  if (s1==null) {
    s1 = new Analysor(this, wavesNames[flag], 1);
    s2 = new Analysor(this, audioNames[flag], 40);
  } else {
    s1.changeSource(wavesNames[flag]);
    s2.changeSource(audioNames[flag]);
  }
  imgCoordonnees = createGeoImage(imageNames[flag]);


  dark = finalColorArray[flag][0];
  medium = finalColorArray[flag][1];
  bright = finalColorArray[flag][2];
}

//Calcul colonnes selon le spectrogramme
void getCol() {
  getData();
  colorArray.clear();
  globalPercentage = 0;
  for (int x = 0; x < img.width; x++) {
    float sumBrightness = 0;
    for (int y = 0; y < img.height; y++) {
      color c = img.get(x, y);
      float brightnessValue = brightness(c);
      sumBrightness += brightnessValue;
    }
    float averageBrightness = sumBrightness / img.height;
    colorArray.append(int(averageBrightness));
    stroke(averageBrightness); // Dessinez la moyenne de luminosité en tant que ligne verticale
    line(x, 0, x, height);
  }

  for (int i = 0; i <greyArray.length; i++) {
    int numberOfCollumn = greyArray.length;
    int from = i * colorArray.size() / numberOfCollumn;
    int to = from + colorArray.size() / numberOfCollumn;

    greyArray[i] = getSumOfItemInIntList(colorArray, from, to) / (colorArray.size() / numberOfCollumn);
    globalPercentage += greyArray[i];
  }
}

int getSumOfItemInIntList(IntList list, int from, int to) {
  int sum = 0;
  for (int i = from; i < to; i++) {
    sum += list.get(i);
  }
  return sum;
}

//Création du spectre sonore selon l'audio
void wave() {
  s2.runAnalyse();
  int freq = 1;
  float phi = 0;
  float modFreq = 5;
  float angle;
  float y;

  translate(0, height/2);

  push();
  frameRate(20);
  strokeWeight(5);
  fill(255);
  beginShape();
  for (int i=0; i<=width; i++) {
    angle = map(i, 0, width, 0, TWO_PI);
    float info = sin(angle * freq + radians(phi));
    float carrier = cos(angle * modFreq*s2.getChannel(60));
    y = info * carrier ;
    y = y * (height/4);
    vertex(i, y);
  }
  endShape();
  pop();
}

void oscEvent(OscMessage msg) {
  // Cette fonction est appelée chaque fois qu'un message OSC est reçu

  // Affichez le message OSC reçu dans la console
  println(msg.addrPattern());

  // Vous pouvez traiter le message OSC ici en fonction de son contenu
  if       (int(msg.addrPattern()) == 0) setFlagState(0);
  else if  (int(msg.addrPattern()) == 1) setFlagState(1);
  else if  (int(msg.addrPattern()) == 2) setFlagState(2);
  else if  (int(msg.addrPattern()) == 3) setFlagState(3);
}

void setFlagState(int flagState) {
  flagIsInit = false;
  flag = flagState;
  clear();
}
