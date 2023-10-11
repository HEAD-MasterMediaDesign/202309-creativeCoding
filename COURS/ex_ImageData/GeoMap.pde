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
	//-------------------------------------------------------------
	//	MAP
	//-------------------------------------------------------------
	float mapX(float v) {
		//setX(v);
		return map(v,xMin,xMax,x,w);
	}
	float mapY(float v) {
		//setY(v);
		return map(v,yMin,yMax,y,h);
	}
	
	//-------------------------------------------------------------
	//	SET
	//-------------------------------------------------------------
	void setX(float v) {
		if (firstPoint ==  true) {
			xMin = v;
			xMax = v;
			firstPoint = false;
		} else{	
			if (v < xMin) {
				xMin = v;
			}
			if (v > xMax) {
				xMax = v;
			}
		}
	}
	
	void setY(float v) {
		if (firstPoint ==  true) {
			yMin = v;
			yMax = v;
			firstPoint = false;
		} else{	
			if (v < yMin) {
				yMin = v;
			}
			if (v > yMax) {
				yMax = v;
			}
		}
	}
	//-------------------------------------------------------------
	//	DRAW
	//-------------------------------------------------------------
	void debugDraw() {
		//stroke(255);
		//noFill();
		//rect(x,y,w,h);
		
		//fill(0);
		//text("xMin : " + xMin + "  xMax : " + xMax,x + 10,y + 20);
		//text("yMin : " + yMin + "  yMax : " + yMax,x + 10,y + 40);
	}
}