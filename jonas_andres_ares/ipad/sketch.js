let table;
let networkData;

let networkDataXSorted;
let networkDataYSorted;

let minLat, maxLat, minLong, maxLong;
let totalLatRange, totalLongRange;

let totalXMeter = 0,
  totalYMeter = 0;

let viewXOrigin = 13000;
let viewYOrigin = 1050;
let viewXWidth = 100;
let viewYHeight;

let trailGraphics;

let trailPositions = [];

let wifiCount = 0;
let bluetoothCount = 0;

let song;

function preload() {
  table = loadTable("wigle-data.csv", "csv", "header");
}

function setup() {
  createCanvas(windowWidth, windowHeight, P2D);
  networkData = table.rows.map((entry) => entry.obj);

  trailGraphics = createGraphics(windowWidth, windowHeight);

  calculateTotalArea();

  for (let i = 0; i < networkData.length; i++) {
    let pLat = parseFloat(networkData[i].Latitude);
    let pLong = parseFloat(networkData[i].Longitude);

    if (!(pLat && pLong)) continue;

    const m = coordinatesToMeter(pLong, pLat);
    networkData[i].xMeter = m.xMeter;
    networkData[i].yMeter = m.yMeter;

    networkData[i].signalStrength = map(
      parseInt(networkData[i].RSSI),
      0,
      -121,
      1,
      0
    );
    networkData[i].index = i;
  }

  totalXMeter =
    turf.distance(
      turf.point([minLong, maxLat]),
      turf.point([maxLong, maxLat])
    ) * 1000;

  totalYMeter =
    turf.distance(
      turf.point([minLong, maxLat]),
      turf.point([minLong, minLat])
    ) * 1000;

  console.log("🚀 ~ setup ~ totalXMeter:", totalXMeter);
  console.log("🚀 ~ setup ~ totalYMeter:", totalYMeter);

  networkDataXSorted = _.sortBy(networkData, function (p) {
    return p.xMeter;
  });
  networkDataYSorted = _.sortBy(networkData, function (p) {
    return p.yMeter;
  });

  viewYHeight = viewXWidth / (width / height);

  console.log("🚀 ~ setup ~ networkData:", networkData);

  const coord = meterToCoordinate(
    networkData[2138].xMeter,
    networkData[2138].yMeter
  );
  console.log("🚀 ~ setup ~ coord:", coord);
  console.log("🚀 ~ setup ~ networkData[20138]:", networkData[2138]);
}

function draw() {
  background(0);

  trailGraphics.noStroke();
  // trailGraphics.fill(0,0,0, 10);
  // trailGraphics.rect(0,0,width, height);
  trailGraphics.fill("blue");
  trailGraphics.circle(width / 2, height / 2, 14);
  image(trailGraphics, 0, 0);

  const deltaX = mouseX - pmouseX;
  const deltaY = mouseY - pmouseY;

  viewXOrigin -= (deltaX / width) * viewXWidth;
  viewYOrigin -= (deltaY / height) * viewYHeight;

  // // console.log("🚀 ~ draw ~ touches:", touches);

  // if(touches === 2){
  //   const pinchDistance = dist(touches[0].x, touches[0].y, touches[1].x, touches[1].y);
  //   console.log("🚀 ~ draw ~ distance:", pinchDistance);
  // }

  fill(255);
  noStroke();

  drawArea();

  trailPositions.push(pixelToMeters(width / 2, height / 2));
  if (trailPositions.length > 20) trailPositions.shift();

  // for (let i = 0; i < trailPositions.length; i++) {
  //   const inter = i/trailPositions.length;
  //   const pix = meterToPixel(trailPositions[i].xMeter, trailPositions[i].yMeter);
  //   fill(0,0,255,inter * 255);
  //   circle(pix.xPixel, pix.yPixel, 14 )
  // }

  textSize(16);
  textAlign(LEFT);
  text(round(frameRate()) + " FPS", 20, 20);

  text(
    "x: " + Math.round(viewXOrigin) + " y: " + Math.round(viewYOrigin),
    20,
    height - 20
  );

  const currentPosition = pixelToMeters(width / 2, height / 2);
  const currentCoordinate = meterToCoordinate(
    currentPosition.xMeter,
    currentPosition.yMeter
  );

  textAlign(RIGHT);
  text(
    currentCoordinate.lat.toFixed(5) +
      "°N, " +
      currentCoordinate.long.toFixed(5) +
      "°E",
    width - 20,
    height - 20
  );

  noFill();
  stroke(255);
  strokeWeight(3);
  const circle1State = (millis() % 3000) / 3000;
  const circle2State = ((millis() + 1000) % 3000) / 3000;
  const circle3State = ((millis() + 2000) % 3000) / 3000;

  stroke(map(circle1State, 0, 1, 255, 0));
  circle(width / 2, height / 2, circle1State * 400);
  stroke(map(circle2State, 0, 1, 255, 0));
  circle(width / 2, height / 2, circle2State * 400);
  stroke(map(circle3State, 0, 1, 255, 0));
  circle(width / 2, height / 2, circle3State * 400);
  // circle(width/2, height/2, ((millis() + 1000) % 2000) * 0.2)

  // image(img, x, y, width, height)

  // drawingContext.filter = 'blur('+str(2)+'px)';
}

function drawArea() {
  viewYHeight = viewXWidth / (width / height);

  const xPointsInView = findElementsInRange(
    networkDataXSorted,
    viewXOrigin,
    viewXOrigin + viewXWidth,
    "xMeter"
  );
  const yPointsInView = findElementsInRange(
    networkDataYSorted,
    viewYOrigin,
    viewYOrigin + viewYHeight,
    "yMeter"
  );
  const pointsInView = _.intersectionBy(xPointsInView, yPointsInView, "index");

  for (let i = 0; i < pointsInView.length; i++) {
    let pXMeter = pointsInView[i].xMeter;
    let pYMeter = pointsInView[i].yMeter;

    const { xPixel, yPixel } = meterToPixel(pXMeter, pYMeter);

    wifiCount = 0;
    bluetoothCount = 0;

    // console.log("🚀 ~ drawArea ~ pointsInView[i].type:", pointsInView[i].type);
    if (pointsInView[i].Type === "BT" || pointsInView[i].Type === "BLE") {
      const noiseX = noise(pXMeter + millis() * 0.0004);
      const noiseY = noise(pYMeter + millis() * 0.0004 + 8989);
      // map(noiseX, 0,1 -10, 10)
      circle(
        xPixel + map(noiseX, 0, 1, -120, 120),
        yPixel + map(noiseY, 0, 1, -120, 120),
        5
      );

      bluetoothCount += 1;
    } else if (pointsInView[i].Type === "WIFI") {
      // rectMode(CENTER);
      circle(xPixel, yPixel, 10);

      wifiCount += 1;
    }
  }
}

function pixelToMeters(xPixel, yPixel) {
  const xMeter = (xPixel / width) * viewXWidth + viewXOrigin;
  const yMeter = (yPixel / height) * viewYHeight + viewYOrigin;
  return { xMeter, yMeter };
}

function meterToPixel(xMeter, yMeter) {
  const xPixel = ((xMeter - viewXOrigin) / viewXWidth) * width;
  const yPixel = ((yMeter - viewYOrigin) / viewYHeight) * height;
  return { xPixel, yPixel };
}

function meterToCoordinate(xMeter, yMeter) {
  const long = (xMeter / totalXMeter) * (maxLong - minLong) + minLong;
  const lat = (yMeter / totalYMeter) * (minLat - maxLat) + maxLat;
  return { long, lat };
}

function coordinatesToMeter(longitude, latitude) {
  const xMeter =
    turf.distance(
      turf.point([minLong, maxLat]),
      turf.point([longitude, maxLat])
    ) * 1000;
  const yMeter =
    turf.distance(
      turf.point([minLong, maxLat]),
      turf.point([minLong, latitude])
    ) * 1000;
  return { xMeter, yMeter };
}

function findElementsInRange(sortedArray, min, max, valueKey) {
  const startIndex = _.sortedIndexBy(
    sortedArray,
    { [valueKey]: min },
    (obj) => obj[valueKey]
  );
  const endIndex = _.sortedIndexBy(
    sortedArray,
    { [valueKey]: max },
    (obj) => obj[valueKey]
  );
  return _.slice(sortedArray, startIndex, endIndex);
}

function mousePressed() {
  fullscreen(true);
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}

function calculateTotalArea() {
  minLat = 90;
  maxLat = -90;

  minLong = 180;
  maxLong = -180;

  for (let i = 0; i < networkData.length; i++) {
    let lat = parseFloat(networkData[i].Latitude);
    let long = parseFloat(networkData[i].Longitude);
    if (!(lat && long)) continue;

    // Calculate min and max latitude
    if (lat < minLat) {
      minLat = lat;
    }
    if (lat > maxLat) {
      maxLat = lat;
    }

    // Calculate min and max longitude
    if (long < minLong) {
      minLong = long;
    }
    if (long > maxLong) {
      maxLong = long;
    }
  }
  console.log("🚀 ~ calculateTotalArea ~ minLong:", minLong);
  console.log("🚀 ~ calculateTotalArea ~ maxLong:", maxLong);

  console.log("🚀 ~ calculateTotalArea ~ minLat:", minLat);
  console.log("🚀 ~ calculateTotalArea ~ maxLat:", maxLat);

  totalLatRange = maxLat - minLat;
  console.log("🚀 ~ calculateTotalArea ~ totalLatRange:", totalLatRange);
  totalLongRange = maxLong - minLong;
  console.log("🚀 ~ calculateTotalArea ~ totalLongRange:", totalLongRange);
}

playSound();
