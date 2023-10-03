GeoGpx map;

void setup(){
	size(800,800);
	map = new GeoGpx();
	map.addGpx("05_06_2016_Rando_course.gpx");
	map.createGeoImages(sketchPath()+"/data/","JPG");

	map.setMap(30,30,800,400);
}


void draw(){
	background(0);
	map.drawDebug();


}