void glitch() {
  if (isglitch== true) {

    blendMode(DIFFERENCE);

    stroke(random(10), 100 - 100 * sin(radians(a)), 0, 10);

    strokeWeight(random(1, 5));

    int n = 0;
    while (n < num) {
      line(x, y, width + xStep, y);
      y += yStep;

      if (y > height) {
        y = yStep / 2;
        x += xStep;
      }

      if (x > width) {
        x = 2;
      }

      n++;
      a += a_;
    }
    a_ += random(0.05);
  }
}
