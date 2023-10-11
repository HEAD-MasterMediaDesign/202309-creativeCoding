class CardRecto {
  //variables generales pour la carte
  float xCard;
  float yCard;
  int cardWidth;
  int cardHeigth;
  Image carteImage;
  
  PGraphics pgCardRecto;


  //position elements
  int positionMode=CENTER;

  //constructeur / call 1 time
  CardRecto(float _xCard, float _yCard, int _width, int _heigth) {
     pgCardRecto = createGraphics(900,600);
    //attribution variable carte
    xCard = _xCard;
    yCard =_yCard;
    cardWidth =_width;
    cardHeigth=_heigth;
    carteImage = new Image(pgCardRecto);
  }

  void update() {
    pgCardRecto.beginDraw();
    //configuration de la carte postale
    pgCardRecto.noStroke();
    //noFill();
    //pgCardRecto.rectMode(positionMode);
    //pgCardRecto.rect(xCard, yCard, cardWidth, cardHeight);
    carteImage.draw();
    pgCardRecto.endDraw();
  }
}
