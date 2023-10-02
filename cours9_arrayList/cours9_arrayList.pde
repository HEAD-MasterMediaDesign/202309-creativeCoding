String[] stringArray = {
    "Bonjour",
    "Salut",
    "Coucou",
    "Hello",
    "Hi",
    "Salutations",
    "Hey",
    "Allo",
    "Yo",
    "Bonjour à tous",
    "Bonjour tout le monde",
    "Bonjour cher ami",
    "Salut à vous",
    "Coucou les amis",
    "Hello there",
    "Hi folks",
    "Allo tout le monde",
};


// voir https://processing.org/reference/color_.html
// color() return int type, c'est pourquoi on fait un list de Integer
ArrayList<Integer> colors = new ArrayList();

PFont myFont;

void setup() {
  size(500, 500);
  background(255);

  myFont = loadFont("Avenir-Heavy-50.vlw");
  
  for(int i = 0; i < stringArray.length; i++) {
    colors.add(
      color(
        random(255),
        random(255),
        random(255)
      )
    );
  }

  frameRate(3);
}

void draw() {
  if(frameCount % 3 == 0) background(255);
  
  int nombreDeI = stringArray.length;

  textFont(myFont);
  textSize(50);
  textAlign(CENTER);

  for(int i = 0; i < nombreDeI; i++) {
    fill(colors.get(i));

    text(
      stringArray[i],
      random(width),
      random(height)
    );

  }
}
