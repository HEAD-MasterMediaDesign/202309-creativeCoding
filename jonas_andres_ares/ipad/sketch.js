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

function preload() {
  table = loadTable("wigle-data.csv", "csv", "header");
}

function setup() {
  createCanvas(windowWidth, windowHeight, P2D);
  networkData = table.rows.map((entry) => entry.obj);

  calculateTotalArea();

  for (let i = 0; i < networkData.length; i++) {
    let pLat = parseFloat(networkData[i].Latitude);
    let pLong = parseFloat(networkData[i].Longitude);

    if (!(pLat && pLong)) continue;

    networkData[i].xMeter =
      turf.distance(
        turf.point([minLong, maxLat]),
        turf.point([pLong, maxLat])
      ) * 1000;
    networkData[i].yMeter =
      turf.distance(
        turf.point([minLong, maxLat]),
        turf.point([minLong, pLat])
      ) * 1000;

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

  meterToCoordinate(networkData[20138].xMeter, networkData[20138].yMeter)
  console.log("🚀 ~ setup ~ networkData[20138]:", networkData[20138]);
}

function draw() {
  background(0);

  const deltaX = mouseX - pmouseX;
  const deltaY = mouseY - pmouseY;

  viewXOrigin -= (deltaX / width) * viewXWidth;
  viewYOrigin -= (deltaY / height) * viewYHeight;

  // // console.log("🚀 ~ draw ~ touches:", touches);

  // if(touches === 2){
  //   const pinchDistance = dist(touches[0].x, touches[0].y, touches[1].x, touches[1].y);
  //   console.log("🚀 ~ draw ~ distance:", pinchDistance);
  // }

  drawArea();

  fill(255);
  noStroke();
  text(round(frameRate()) + " FPS", 20, 20);

  text(
    "x: " + Math.round(viewXOrigin) + " y: " + Math.round(viewYOrigin),
    20,
    height - 20
  );
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
  return long, lat;
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
    // const xPixel = ((pXMeter - viewXOrigin) / viewXWidth) * width;
    // const yPixel = ((pYMeter - viewYOrigin) / viewYHeight) * height;

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
    } else if (pointsInView[i].Type === "WIFI") {
      // rectMode(CENTER);
      circle(xPixel, yPixel, 10);
    }
  }
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
