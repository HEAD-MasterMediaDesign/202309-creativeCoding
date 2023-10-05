class Txt {
  String[] verb;
  String[] adj;
  String[] noun;
  PFont myFont;

  int indexVerb;
  int indexAdj;
  int indexNoun;

  int [] alignPositionX;
  int [] alignPositionY;
  int textAlignX;
  int textAlignY;
  int textPosX;
  int textPosY;
  int textMargin;

  Txt() {
    this.verb = loadStrings("verb+ing.txt");
    this.adj = loadStrings("adj.txt");
    this.noun = loadStrings("noun.txt");
    this.myFont = loadFont("Apple-Chancery-48.vlw");

    this.indexVerb = int(random(verb.length));
    this.indexAdj = int(random(adj.length));
    this.indexNoun = int(random(noun.length));

    this.alignPositionX = new int []{LEFT, RIGHT};
    this.alignPositionY = new int []{TOP, BOTTOM};
    this.textAlignX = alignPositionX[int(random(alignPositionX.length))];
    this.textAlignY = alignPositionY[int(random(alignPositionY.length))];

    this.textMargin = 20;
    this.textPosX=0;
    this.textPosY=0;
  }

  void draw() {

    textFont(myFont);
    textSize(25);

    if (textAlignX == LEFT) textPosX   = textMargin;
    if (textAlignX == RIGHT) textPosX   = width - textMargin;
    if (textAlignY == TOP) textPosY   = textMargin;
    if (textAlignY == BOTTOM) textPosY   = height - textMargin;
    
    textAlign(textAlignX, textAlignY);

    fill(255);

    text(verb[indexVerb]+" "+adj[indexAdj]+" "+noun[indexNoun], textPosX, textPosY);
  }
}
