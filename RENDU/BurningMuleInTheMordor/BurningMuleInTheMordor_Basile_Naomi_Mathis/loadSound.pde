//SOUND______________________________________________
void loadSounds1() {
  for (int i=0; i<3; i++) {
    s1[i] = m.loadFile("data/Son/setup1/"+"son"+(i+1)+".mp3");
    s2[i] = m.loadFile("data/Son/setup1/"+"son2_"+(i+1)+".mp3");
    s3[i] = m.loadFile("data/Son/setup1/"+"son3_"+(i+1)+".mp3"); 
  }
}
