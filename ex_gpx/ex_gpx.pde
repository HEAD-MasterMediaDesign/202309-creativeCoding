GeoGpx map;

void setup(){
	size(1200,800,P2D);
	map = new GeoGpx();
	map.addGpx("05_06_2016_Rando_course.gpx");
	map.createGeoImages(sketchPath()+"/data/","JPG");

	map.setMap(30,30,width-60,height-60);
}


void draw(){
	background(0);
	//map.drawDebug();
	
	ArrayList<pGPX> myTab = map.getPoints();
	int maxPoint = myTab.size();
	
	for(int i=0;i<myTab.size();i+=30){
		pGPX p = myTab.get(i);
		fill(map(i,0,maxPoint,0,255),255,255);
		ellipse(p.px,p.py,20,20);
		fill(255,80);
		text(p.lat+"  "+p.lon,p.px+100,p.py+10);
	}
	

	ArrayList<GeoImage> allImages = map.getImages();
	int maxImage = allImages.size();

	float sizeImage = 0.05;

	for(int i=0;i<allImages.size();i++){
		GeoImage p = allImages.get(i);
		imageMode(CENTER);

		pushMatrix();
		translate(p.px,p.py);
		rotate(+PI/2);
		image(
			p.getImage(),
			0,0,
			p.getImage().width*sizeImage,p.getImage().height*sizeImage
		);

		popMatrix();
	}
	
	
}
