
GeoImage img;

GeoImage [] colImages;

//-------------------------------------------------------------
//	SETUP
//-------------------------------------------------------------
void setup(){
	size(1200, 800);

	//create one picture from the data folder with the jpg extension
	img = createGeoImage("IMG_20230923_171133.jpg");

	//create one collection of picture, with all the pictures in the data folder with the jpg extension
	colImages = createGeoImages(colImages,sketchPath()+"/data/","jpg");

	String [] listFiles = listFileNames(sketchPath()+"/data/","jpg");
	println(listFiles);
}

//-------------------------------------------------------------
//	DRAW
//-------------------------------------------------------------
void draw(){
	background(0);
}