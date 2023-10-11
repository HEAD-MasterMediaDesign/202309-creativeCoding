import processing.pdf.*;

//Declaration classe card verso
CardVerso postCard;
CardRecto goCard;

//variable pour parents sur soundfile
PApplet parent = this;

//Variable declaration pour classe card verso
float xCard;
float yCard;
int cardWidth;
int cardHeigth;

//Variable declaration pour classe card recto
float xCardRecto;
float yCardRecto;

void setup() {
  fullScreen(2);
  background(0);

  //Attribution valeurs verso carte
  cardWidth = 900;
  cardHeigth = 600;
  xCard = width/2;
  yCard = height-(height/4);
  xCardRecto = width/2;
  yCardRecto = height/4;

  //Création d'une nouvelle carte
  postCard = new CardVerso(xCard, yCard, cardWidth, cardHeigth);
  goCard= new CardRecto(xCardRecto, yCardRecto, cardWidth, cardHeigth);

  //voir pour framerate
  frameRate(60);
}


void draw() {
  background(0);
  postCard.draw();
  goCard.update();
  imageMode(CENTER);
  image(goCard.pgCardRecto, width / 2, height / 4);
}
void mouseClicked() {
  if (mouseButton == RIGHT) {
    println("droit");
    postCard.textEffect.replaceText = true;
    goCard.carteImage.rectoImage = true;
    goCard.carteImage.sample.play();
    goCard.carteImage.rms.input(goCard.carteImage.sample);
  } else if (mouseButton == LEFT) {
    println("gauche");
    int randomIndexOriginal = int(random(postCard.textEffect.textArrayOriginal.length));
    postCard.textEffect.currentText = postCard.textEffect.textArrayOriginal[randomIndexOriginal];
    postCard.textEffect.replaceText = false;
    int randomIndexImage = int (random(goCard.carteImage.images.length));
    goCard.carteImage.currentImage = goCard.carteImage.images[randomIndexImage];
    goCard.carteImage.rectoImage = false;
    goCard.carteImage.frameCounter = 0;
  }
}

void keyReleased(){
  if(keyCode==32){
    generatePostCard();
  }
}


PGraphicsPDF pdf;
void generatePostCard(){
  
  int milli_width=150*2;
  int milli_height=100*2;
  //float marge=100;
  
  pdf = (PGraphicsPDF) createGraphics(milli_width, milli_height, PDF, "test"+int(random(10000))+".pdf");
  pdf.beginDraw();
  pdf.textMode(SHAPE);

  goCard.pgCardRecto.loadPixels();

  pdf.image(
    goCard.pgCardRecto.get(0,0,goCard.pgCardRecto.width,goCard.pgCardRecto.height),
    0,0,milli_width, milli_height
  );
  
  
  pdf.nextPage();
  
  pdf.image(
    postCard.pg.get(0,0,postCard.pg.width,postCard.pg.height),
    0,0,milli_width, milli_height
  );
  
  pdf.dispose();
  pdf.endDraw();
  
  //endRecord();
  
}
