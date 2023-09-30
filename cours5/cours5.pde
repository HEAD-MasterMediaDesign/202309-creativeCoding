PImage bob;

void setup() {
  size(800, 800);
  bob = loadImage("bob.png");
  bob.resize(bob.width/4, bob.height/4);
}

void draw() {
  if (mousePressed) {
    float vit = dist(mouseX,mouseY,pmouseX,pmouseY);
    
    float taille = 100-vit*4;
    if(taille<1)taille=1;
    
    rectMode(CENTER);
    rect(mouseX,mouseY,taille,taille);
    
    //tint(random(10, 100), random(100, 255), random(100, 255), random(255));
    imageMode(CENTER);
    
    image(bob, mouseX, mouseY);
    image(bob, width-mouseX, mouseY);
    image(bob, width-mouseX, height-mouseY);
    image(bob, mouseX, height-mouseY);
  }
}
