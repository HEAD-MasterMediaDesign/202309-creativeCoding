class Text {
  String[] textArrayOriginal;
  String[] textArrayReplace;
  String currentText;
  int currentIndex = 0;
  int randomIndexOriginal;
  int randomIndexReplace = int(random(0, 5));
  int interval = 1600; // 1/2 seconde (en millisecondes)
  int lastTime;
  boolean replaceText = false;
  float posXTextChange;
  float posYTextChange;
  float xWidth;
  float yHeight;
  PFont myFont;


  Text(String[] _textArrayOriginal, String[] _textArrayReplace, float _posXTextChange, float _posYTextChange) {
    textArrayOriginal = _textArrayOriginal;
    textArrayReplace = _textArrayReplace;
    randomIndexOriginal = int(random(textArrayOriginal.length));
    currentText = textArrayOriginal[randomIndexOriginal];
    lastTime = millis();
    posXTextChange = _posXTextChange;
    posYTextChange = _posYTextChange;

    myFont=createFont("PPNeueMontreal-Medium.otf", 50);
  }

  void draw(PGraphics pg,float _x,float _y) {
    pg.fill(0);
    pg.textSize(25);
    pg.textFont(myFont);
    pg.textAlign(LEFT);
    xWidth = 450;
    yHeight = 400;
    pg.text(currentText, _x, _y, xWidth, yHeight);
    if (replaceText==true) {
      //background(255);
      // Vérifie si une demi-seconde s'est écoulée
      if (millis() - lastTime >= interval) {
        currentIndex++;
        if (currentIndex >= min(currentText.length(), textArrayReplace[randomIndexReplace].length())) {
          currentIndex = 0;
        }
        lastTime = millis();
      }

      // Construit le texte avec les caractères interchangeés
      char[] charArray = currentText.toCharArray();
      charArray[currentIndex] = textArrayReplace[randomIndexReplace].charAt(currentIndex);
      currentText = new String(charArray);

      // Affiche le texte mis à jour
      pg.text(currentText, posXTextChange, posYTextChange, xWidth, yHeight);
    }
  }
}
