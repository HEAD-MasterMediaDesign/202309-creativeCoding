class Timbre {
  //variable timbre
  float xTimbre;
  float yTimbre;
  int widthTimbre;
  int heightTimbre;
  PImage monTimbre;
  //contructeur / call 1 time
  Timbre(float _xTimbre, float _yTimbre, int _widthTimbre, int _heightTimbre) {

    //attribution variables
    xTimbre =_xTimbre;
    yTimbre=_yTimbre;
    widthTimbre=_widthTimbre;
    heightTimbre=_heightTimbre;
    monTimbre=loadImage("mont.png");
  }
  void draw(PGraphics pg) {
    monTimbre.filter(GRAY);
    monTimbre.resize(widthTimbre, heightTimbre);
    pg.image(monTimbre, xTimbre, yTimbre);
  }
}
