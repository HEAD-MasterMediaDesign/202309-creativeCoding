class Tourists {
    
    PImage[] imgTourist;
    int indexTourist;
    int TouristTime;
    int collMin;
    int collMax;
    float posX;
    float scalTour;
    
    PGraphics PGTourist;
    int canvasWidth   = 50;
    int canvasHeight  = 50;
    
    
    Tourists(String[] imgTourist, int _canvasWidth, int _canvasHeight) {
        
        
        this.canvasWidth = _canvasWidth;
        this.canvasHeight = _canvasHeight;
        
        
        this.PGTourist = createGraphics(this.canvasWidth, this.canvasHeight,P2D);
        
        this.imgTourist = new PImage[imgTourist.length];
        this.indexTourist = 0;
        this.TouristTime = 0;
        
        for (int t = 0; t < imgTourist.length; t++) {
            this.imgTourist[t] = loadImage("T_0" + str(t + 1) + ".png");
            this.imgTourist[t].filter(BLUR,2);
            
        }
    }
    
    void drawTour() {
        
        this.collMin = 3;
        this.collMax = 9;
        this.posX = random(width / 12 * collMin, width / 12 * collMax);
        this.scalTour = random(875, 1125);
        
        PGTourist.beginDraw();
        
        if (TouristTime == 1) {
            println("im here");
            // background(255);
            this.indexTourist = int(random(imgTourist.length));
            PGTourist.imageMode(CORNER);
            PGTourist.tint(200,0,100,200);
            PGTourist.image(imgTourist[indexTourist], posX - scalTour / 2, height - scalTour, scalTour, scalTour);
            //PGTourist.filter(BLUR, 2);
        }
        TouristTime++;
        PGTourist.endDraw();
    }
    
    
    void clearCanvas() {
        // clearthe PGraphics layer
        this.indexTourist = int(random(imgTourist.length));
        this.TouristTime = 0;
        this.PGTourist.beginDraw();
        this.PGTourist.clear();
        this.PGTourist.endDraw();
        this.drawTour();
    }
    
}
