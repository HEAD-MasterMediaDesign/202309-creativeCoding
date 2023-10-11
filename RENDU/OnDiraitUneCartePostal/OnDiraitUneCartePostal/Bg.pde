class Bg {
    
    //create global variables
    //these array will load and contain all the images
    PImage[] textureArt;
    
    int currentTextureArtIndex;
    float imgRatioArt;
    int time;
    String[] arrColor;
    color randomColor;
    
    // create a PGraphics layer (layer(calques) like in photoshop) to draw the mountain seperatly from the rest of the sketch
    PGraphics PGBg;
    int canvasWidth   = 50;
    int canvasHeight  = 50;
    
    //create constructor, pass in argument the two arrays of images names
    Bg(String[] textureArtNames, int _canvasWidth, int _canvasHeight) {
        
        // initialize global variables, "this." is used to refer to the global variables of the Bg class
        this.canvasWidth = _canvasWidth;
        this.canvasHeight = _canvasHeight;
        this.currentTextureArtIndex = 0;
        this.textureArt = new PImage[textureArtNames.length];
        this.time = 0;
        this.arrColor = new String[]{
            "035bb5",
            "3a7fbd",
            "055cab",
            "095d8e",
            "22478e"};
        this.randomColor = color(unhex(arrColor[int(random(arrColor.length))]));
        
        // initialize the PGraphics layer size with the canvasWidth and canvasHeight
        this.PGBg = createGraphics(this.canvasWidth, this.canvasHeight);
        
        
        // load images from the textureArtNames textureNatNames arrays
        for (int i = 0; i < textureArtNames.length; i++) {
            this.textureArt[i] = loadImage(textureArtNames[i]);
            // getimage ratio and resize it proportionally
            this.imgRatioArt = textureArt[i].width / textureArt[i].height;
            this.textureArt[i].resize(width, height * int(imgRatioArt));
            this.textureArt[i].loadPixels();
        }
        
        currentTextureArtIndex = int(random(textureArt.length));
        // println(imgRatio2 = textureArt[currentTextureArtIndex].width / textureArt[currentTextureArtIndex].height + " ratio texture");
    }
    
    
    void draw() {
        
        // set the background color to a shade of blue
        background(randomColor);
        PGBg.beginDraw();
        
        PGBg.tint(255, 255);
        
         PGBg.background(randomColor);       
        // println(randomColor); 
        PGBg.imageMode(CENTER);
        
        // draw the images with transparency
        PGBg.tint(255, 30);
        PGBg.image(textureArt[currentTextureArtIndex], width / 2, height / 2);
        
        PGBg.endDraw();
    }
    
    void clearCanvas() {
        // clear the PGraphics layer and redraw the background
        this.currentTextureArtIndex = int(random(textureArt.length));   
        this.randomColor = color(unhex(arrColor[int(random(arrColor.length))]));       
        this.PGBg.beginDraw();
        this.PGBg.clear();
        this.PGBg.endDraw();
        this.draw();
    }
    
}
