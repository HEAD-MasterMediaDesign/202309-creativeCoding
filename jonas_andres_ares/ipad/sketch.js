function setup() {
  createCanvas(windowWidth,windowHeight);
}

function draw() {
  background(0)
  
  stroke(255)
  for (let i = 0; i < 20; i++) {
    let y = height/20 * i;
    line(0, y, width, y)
  }
  noStroke()
  fill("blue")
  rect(mouseX, mouseY, 200, 300)
}

function mousePressed() {
  fullscreen(true);
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
