import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.exif.GpsDirectory;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.*;
import com.drew.metadata.Tag;
import com.drew.metadata.*;
import com.drew.imaging.jpeg.JpegMetadataReader;

class GeoGpx{

	XML xml;
	ArrayList<pGPX> tabPoint;
	//-------------------------------------------------------------
	//CONSTRUCTOR
	//-------------------------------------------------------------
	GeoGpx() {
		tabImages = new ArrayList<GeoImage>();
	}
	
	//-------------------------------------------------------------
	//ADD GPX
	//-------------------------------------------------------------
	void addGpx(String path) {
		xml = loadXML(sketchPath() + "/data/" + path);
		
		XML track = xml.getChild("trk").getChild("trkseg");
		tabPoint = new ArrayList<pGPX>();
		XML[] point = track.getChildren("trkpt");
		
		for (int i = 0; i < point.length; i++) {
			pGPX p = new pGPX(i);
			p.lat = point[i].getFloat("lat");
			p.lon = point[i].getFloat("lon");
			p.ele = int(float(point[i].getChild("ele").getContent()));
			p.time = point[i].getChild("time").getContent();
			try {
				p.temp = float(point[i].getChild("extensions").getChild("gpxtpx:TrackPointExtension").getChild("gpxtpx:atemp").getContent());
				p.cardio = int(float(point[i].getChild("extensions").getChild("gpxtpx:TrackPointExtension").getChild("gpxtpx:hr").getContent()));
			}
			catch(Exception e) {
				println("CARDIO NOT FOUND");
			}
			p.print();
			tabPoint.add(p);
		} 	
	}

	//-------------------------------------------------------------
	//get points
	//-------------------------------------------------------------
	ArrayList<pGPX> getPoints() {
		return tabPoint;
	}

	//-------------------------------------------------------------
	//SET MAP
	//-------------------------------------------------------------
	GeoMap m;
	void setMap(float x, float y, float w, float h) {
		m = new GeoMap(x, y, w, h);
		
		if(tabPoint.size() > 0){
			//m.ref(tabPoint.get(0).lat, tabPoint.get(0).lon);
			for (int i = 0; i < tabPoint.size(); i++) {
				m.setPoint(tabPoint.get(i).lat,tabPoint.get(i).lon);
			}
			for (int i = 0; i < tabPoint.size(); i++) {
				tabPoint.get(i).px = m.mapX(tabPoint.get(i).lat);
				tabPoint.get(i).py = m.mapY(tabPoint.get(i).lon);
			}
		}else{
			println("ERROR > tabPoint is empty");
		}

		if(tabImages.size() > 0){
			
			for (int i = 0; i < tabImages.size(); i++) {
				m.setPoint(tabImages.get(i).lat,tabImages.get(i).lon);
			}
			
			for (int i = 0; i < tabImages.size(); i++) {
				tabImages.get(i).px = m.mapX(tabImages.get(i).lat);
				tabImages.get(i).py = m.mapY(tabImages.get(i).lon);
			}
		}
	}

	//-------------------------------------------------------------
	//CONVERT HOUR TO DECIMAL
	//-------------------------------------------------------------
	public float convertHourToDecimal(String degree) { 
		//degree.matches("(-)?[0-6][0-9]\"[0-6][0-9]\'[0-6][0-9](.[0-9]{1,5})?");
		String[] s1 = splitTokens(degree, "\"\' °");
		println(">>> "+s1[0]+" "+s1[1]+" "+s1[2]);
		s1[2] = s1[2].replace(',','.');
		float calc = float(s1[0])+float(s1[1])/60+float(s1[2])/3600;
		return calc;
	}
		
	//-------------------------------------------------------------
	//LIST FILE NAMES
	//-------------------------------------------------------------
	String[] listFileNames(String dir,String key) {
		File file = new File(dir);
	
		if (file.isDirectory()) {
			String names[] = file.list();
			StringList inventory = new StringList();
		
			for (int i = 0; i < names.length; ++i) {
				String [] analyse=split(names[i],".");
				if(analyse[1].equals(key)){
					//println(names[i]);
					inventory.append(names[i]);
				}
			}
			return inventory.array();
		} else {
			// If it's not a directory
			return null;
		}
	}

	//-------------------------------------------------------------
	//GeoImage
	//-------------------------------------------------------------
	ArrayList<GeoImage> tabImages;

	//-------------------------------------------------------------
	//createGeoImage
	//-------------------------------------------------------------
	GeoImage createGeoImage(String name) {
		PImage ima = loadImage(name);
		float gpsLat = 0;
		float gpsLong = 0;
		float gpsAltitude = 0;
		float gpsSpeed = 0;
		String time = "";

		try {
			String path = sketchPath() + "/data/" + name;
			println(path);
			File jpegFile = new File(path);
			Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);
			println(metadata.toString());

			for (Directory directory : metadata.getDirectories()) {
				for (Tag allTags : directory.getTags()) {
					/*
					println("-------------------------------------");
					println(">> "+allTags.getTagName());
					println("-------------------------------------");
					println(allTags.getDescription());
					*/
					if (allTags.getTagName().equals("GPS Latitude")) {
						gpsLat = convertHourToDecimal(allTags.getDescription());
					}

					if (allTags.getTagName().equals("GPS Longitude")) {
						gpsLong = convertHourToDecimal(allTags.getDescription());
					}
					if (allTags.getTagName().equals("GPS Speed")) {//GPS Speed
						gpsSpeed = float(allTags.getDescription());
					}
					if (allTags.getTagName().equals("GPS Altitude")) {//GPS Speed
						String[] s1 = splitTokens(allTags.getDescription(), " ");
						gpsAltitude = float(s1[0]);
					}
					if (allTags.getTagName().equals("File Modified Date")) {//GPS Speed
						time = allTags.getDescription();
					}
				}
			}
		} 
		catch(Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		GeoImage pt = new GeoImage(ima,gpsLat,gpsLong,gpsAltitude,gpsSpeed,time);

		println("--------------------------------------");
		println(name);
		println("Lat : " + gpsLat);
		println("Long : " + gpsLong);
		println("Speed : " + gpsSpeed);
		println("Alti : " + gpsAltitude);
		println("Time : " + time);
	
		tabImages.add(pt);
		return pt;
	}

	//-------------------------------------------------------------
	//get points
	//-------------------------------------------------------------
	ArrayList<GeoImage> getImages() {
		return tabImages;
	}

	//-------------------------------------------------------------
	// createGeoImages
	//-------------------------------------------------------------
	GeoImage[] createGeoImages(String path, String ext) {
		String[] names = listFileNames(path, ext);
		
		println(">>> "+names.length);

		GeoImage[] geoImages = new GeoImage[names.length];
		
		for (int i = 0; i < names.length; i++) {
			geoImages[i] = createGeoImage(names[i]);
		}
		return geoImages;
	}
	
	//-------------------------------------------------------------
	//-------------------------------------------------------------
	// DRAW DEBUG
	//-------------------------------------------------------------
	void drawDebug() {
		m.drawDebug();
		for (int i = 0; i < tabPoint.size(); i++) {
			tabPoint.get(i).debugDraw();
		}
		for (int i = 0; i < tabImages.size(); i++) {
			tabImages.get(i).debugDraw();
		}
	}
}

//-------------------------------------------------------------
//		Classe pGPX
//-------------------------------------------------------------
class pGPX{
	int index;
	float lat;
	float lon;
	float ele;
	String time;
	float temp;
	float cardio;
	
	float px;
	float py;
	
	pGPX(int index) {
		this.index = index;
	}

	pGPX() {
	}
	
	void debugDraw() {
		stroke(255, 255, 0,100);
		line(px-2, py, px+2, py);
		line(px, py-2, px, py+2);
	}
	
	void print() {
		println("--------------------------------------------");
		println("index : " + index);
		println("lat : " + lat);
		println("lon : " + lon);
		println("ele : " + ele);
		println("cardio : " + cardio);
	}
}

//-------------------------------------------------------------
// GeoImage class
//-------------------------------------------------------------
class GeoImage extends pGPX{
	PImage ima;
	float speed;

	//-------------------------------------------------------------
	//CONSTRUCTOR
	//-------------------------------------------------------------
	GeoImage(PImage _ima, float gpsLat, float gpsLong, float gpsAltitude, float gpsSpeed, String time) {
		this.ima = _ima;
		this.lat = gpsLat;
		this.lon = gpsLong;
		this.ele = gpsAltitude;
		this.speed = gpsSpeed;
		this.time = time;
	} 
	//-------------------------------------------------------------
	//RESIZE
	//-------------------------------------------------------------
	void resize(int w,int h) {
		ima.resize(w,h);
	}

	//-------------------------------------------------------------
	//DRAW
	//-------------------------------------------------------------
	void debugDraw() {
		stroke(0, 255, 0);
		float l = 6;
		line(px-l, py-l, px+l, py+l);
		line(px+l, py-l, px-l, py+l);
	}
	//-------------------------------------------------------------
	//GET IMAGE
	//-------------------------------------------------------------
	PImage getImage() {
		return ima;
	}
}

//-------------------------------------------------------------
// DRAW
//-------------------------------------------------------------
class GeoMap {
	float xMin = 0;
	float xMax = 0;
	float yMin = 0;
	float yMax = 0;
	
	float x;
	float y;
	float w;
	float h;
	
	boolean firstPoint = true;
	
	//-------------------------------------------------------------
	//	GEO MAP
	//-------------------------------------------------------------
	GeoMap() {
		println("new GeoMap");
	}
	GeoMap(float x, float y, float w, float h) {
		println("new GeoMap");
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}
	//-------------------------------------------------------------
	//	MAP
	//-------------------------------------------------------------
	float mapX(float v) {
		return map(v,xMin,xMax,x,w);
	}
	float mapY(float v) {
		return map(v,yMin,yMax,y,h);
	}
	//-------------------------------------------------------------
	//	SET
	//-------------------------------------------------------------
	void setPoint(float vx,float vy) {
		if (firstPoint ==  true) {
			xMin = vx;
			xMax = vx;
			yMin = vy;
			yMax = vy;
			firstPoint = false;
		} else{	
			if (vx < xMin) {
				xMin = vx;
			}
			if (vx > xMax) {
				xMax = vx;
			}
			if (vy < yMin) {
				yMin = vy;
			}
			if (vy > yMax) {
				yMax = vy;
			}
		}
	}
	//-------------------------------------------------------------
	//	DRAW
	//-------------------------------------------------------------
	void drawDebug() {
		stroke(255);
		noFill();
		rect(x,y,w,h);
		
		fill(0);
		text("xMin : " + xMin + "  xMax : " + xMax,x + 10,y + 20);
		text("yMin : " + yMin + "  yMax : " + yMax,x + 10,y + 40);
	}
}
