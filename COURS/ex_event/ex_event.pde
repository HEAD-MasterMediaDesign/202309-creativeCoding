Button button;

void exemple_2() {
  println("coucou");
};

static class Exemple_3{
  
  static String messageSample = "before";
  
  static void callback() {
    println(messageSample);
  }
}

void setup() {
  size(400, 200);
  button = new Button(150, 100, 100, 40);
  
  // Définir le callback
  button.setCallback(new Callback() {
    //@Override
    void onClick() {
      println("Bouton cliqué !");
    }
  });
}

void draw() {
  background(220);
  
  // Afficher le bouton
  button.display();
}

interface Callback {
  void onClick();
}

class Button {
  float x, y, w, h;
  String label = "Cliquez-moi";
  Callback callback;

  Button(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void setCallback(Callback callback) {
    this.callback = callback;
  }

  void display() {
    fill(0, 150, 255);
    rect(x, y, w, h);
    fill(255);
    textSize(16);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }

  void checkClick(float mouseX, float mouseY) {
    
    if (callback == null) return;
    
    if (
      mouseX >= x 
      && mouseX <= x + w 
      && mouseY >= y 
      && mouseY <= y + h
    ) {
      callback.onClick();
      exemple_2();
      Exemple_3.messageSample = "after message " + int(random(25));
      Exemple_3.callback();
    }
    
  }

}

void mouseClicked() {
  // Vérifier si la souris a cliqué sur le bouton
  button.checkClick(mouseX, mouseY);
}
