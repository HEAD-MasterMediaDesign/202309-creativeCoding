//AUDIO TRIGG_________________________________________s
void audioTrigger() {

  //AUDIO TRIGGER POSITIONS__________________________
  for (int i = 0; i< boites.length; i++) {
    detectPlay(s1, boites[i], new int[] {i});
    detectPlay(s2, boites[i], new int[] {i});
    detectPlay(s3, boites[i], new int[] {i});
  }
}

//BOITES INTERACTIVES_________________________________
void trigBoxes() {
  for (int[]box : boites) {
    int minX = box[0];
    int maxX = box[1];
    int minY = box[2];
    int maxY = box[3];

    if (!isZoomed) {
      minX = int(minX * zoom);
      maxX = int(maxX * zoom);
      minY = int(minY * zoom);
      maxY = int(maxY * zoom);

      rect(minX, minY, maxX-minX, maxY-minY, 10);

      noStroke();
      noFill();
      //fill(255, 255, 255, 70); //--- FOR DEBBUGING ---
    }
  }
}
