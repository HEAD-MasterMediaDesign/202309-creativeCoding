class Txt {
  //create global variables
  String[] verb;
  String[] adj;
  String[] noun;
  PFont[] fonts;

  int indexVerb;
  int indexAdj;
  int indexNoun;
  int myFont;

  int[] alignPositionX;
  int[] alignPositionY;
  int textAlignX;
  int textAlignY;
  int textPosX;
  int textPosY;
  int textMargin;

  PGraphics PGText;
  int canvasWidth   = 50;
  int canvasHeight  = 50;


  //create constructor, load txt files and initialize variables
  Txt(int _canvasWidth, int _canvasHeight) {

    this.canvasWidth = _canvasWidth;
    this.canvasHeight = _canvasHeight;

    this.PGText = createGraphics(this.canvasWidth, this.canvasHeight);

    this.verb = loadStrings("verb+ing.txt");
    this.adj = loadStrings("adj.txt");
    this.noun = loadStrings("noun.txt");

    this.fonts = new PFont[4];
    // fonts[0] = loadFont("IvoryTrial-MediumItalic-48.vlw");
    //fonts[1] = loadFont("GTAlpinaItalicVARTrial_Regular-Italic-48.vlw");
    //fonts[2] = loadFont("ABCGaisyrUnlicensedTrial-RegularItalic-48.vlw");
    fonts[0] = loadFont("ABCDiatypeVariableTrial-Regular_Bold-Italic-48.vlw");
    fonts[1] = loadFont("ABCDiatypeVariableTrial-Regular_Bold-48.vlw");
    fonts[2] = loadFont("ABCDiatypeVariableTrial-Regular_Bold-48.vlw");
    fonts[3] = loadFont("ABCDiatypeVariableTrial-Regular_Bold-Italic-48.vlw");

    this.myFont = int(random(fonts.length));

    // get random word from each array
    this.indexVerb = int(random(verb.length));
    this.indexAdj = int(random(adj.length));
    this.indexNoun = int(random(noun.length));

    // get random alignment
    this.alignPositionX = new int[]{LEFT, RIGHT};
    this.alignPositionY = new int[]{TOP};
    this.textAlignX = alignPositionX[int(random(alignPositionX.length))];
    this.textAlignY = alignPositionY[int(random(alignPositionY.length))];

    // set margins
    this.textMargin = 80;
    this.textPosX = 0;
    this.textPosY = 0;
  }

  void drawText() {

    PGText.beginDraw();

    PGText.clear();

    PGText.textFont(fonts[myFont]);
    PGText.textSize(110);

    // set text position
    if (textAlignX == LEFT) textPosX   = textMargin;
    if (textAlignX == RIGHT) textPosX   = width - textMargin;
    if (textAlignY == TOP) textPosY   = textMargin;

    PGText. textAlign(textAlignX, textAlignY);
    PGText.fill(9, 60, 142, 150);

    PGText.text(verb[indexVerb].toUpperCase() + " " + adj[indexAdj].toUpperCase() + " " + noun[indexNoun].toUpperCase(), textPosX, textPosY);
    //drop shadow
    //PGText.filter(BLUR, 10);

    //top layer of text
    PGText.fill(255, 209, 255, 200);
    PGText.text(verb[indexVerb].toUpperCase() + " " + adj[indexAdj].toUpperCase() + " " + noun[indexNoun].toUpperCase(), textPosX-4, textPosY-4);

    PGText.endDraw();
  }

  void clearTxt() {
    // clear the text layer
    //background(255);

    // get random font
    this.myFont = int(random(fonts.length));
    // get random word from each array
    this.indexVerb = int(random(verb.length));
    this.indexAdj = int(random(adj.length));
    this.indexNoun = int(random(noun.length));

    // get random alignment
    this.alignPositionX = new int[]{LEFT, RIGHT};
    this.alignPositionY = new int[]{TOP};
    this.textAlignX = alignPositionX[int(random(alignPositionX.length))];
    this.textAlignY = alignPositionY[int(random(alignPositionY.length))];
    this.drawText();
  }
}
