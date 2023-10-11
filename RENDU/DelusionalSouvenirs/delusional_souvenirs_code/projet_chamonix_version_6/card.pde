class CardVerso {
  //variables generales pour la carte
  float xCard;
  float yCard;
  int cardWidth;
  int cardHeight;
  PFont typoExpediteur;
  
  //appel de la classe text
  Text textEffect;

  //variable pour la classe texte
  float posXTextChange = xCard+340;
  float posYTextChange = yCard+1470;

  //variables pour le timbre
  float xTimbre=width-1760;
  float yTimbre=height-1900;
  int widthTimbre=120;
  int heightTimbre=100;

  //creation instance classe timbre
  Timbre timbrePostal;

  //position elements
  int positionMode=CENTER;
   
  //PGRAPHICS
  PGraphics pg;

  //constructeur / call 1 time
  CardVerso(float _xCard, float _yCard, int _width, int _heigth) {

    //attribution variable carte
    xCard = _xCard;
    yCard =_yCard;
    cardWidth =_width;
    cardHeight=_heigth;

    //appel class text
    String[] originalTexts = loadStrings("monTextePos.txt"); // Charger votre fichier texte original
    String[] replaceTexts = loadStrings("monTexteNeg.txt");   // Charger votre fichier texte de remplacement
    textEffect = new Text(originalTexts, replaceTexts, posXTextChange, posYTextChange);

    //appel class timbre
    timbrePostal = new Timbre (830, 1170, widthTimbre, heightTimbre);
    pg = createGraphics(cardWidth,cardHeight);
  }

  void draw() {
    pg.beginDraw();
    pg.background(255);
    
    //configuration de la carte postale
    pg.noStroke();
    pg.fill(255);
    pg.rectMode(positionMode);
    pg.rect(xCard, yCard, cardWidth, cardHeight);

    //configuration text
    textEffect.draw(pg,260,350);
    
    //affichage ligne verticale
    /*pg.stroke(0);
    pg.strokeWeight(2);
    pg.line(500, 250, 500, 510);*/


    //affichage lignes horizontales
    pg.stroke(0);
    pg.strokeWeight(2);
    pg.line(550, 450, 820, 450);
    pg.line(550, 250, 820, 250);
    pg.line(550, 350, 820, 350);

    //affichage timbre rectangle
    //timbrePostal.draw(pg);
    pg.stroke(0);
    pg.noFill();
    pg.strokeWeight(2);
    pg.rect(850,60,60,75);

    //affichage adresse expediteur
    //textFont(typoExpediteur);
    pg.fill(146, 146, 146);
    pg.textSize(26);
    pg.noStroke();
    pg.text("CHAMONIX - MONT-BLANC", 40, 50);
    //xCard+34, yCard+1470);
    pg.endDraw();
    
    imageMode(CENTER);
    image(pg, width/2, height - height/4);
  }
}
