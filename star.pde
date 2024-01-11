class Star {
  float x, y, z;

  Star() {
    x = random(-maxX, maxX);
    y = random(-maxY, maxY);
    z = random(minZ, maxZ);
  }

  void update() {
    if (floor(speed) != floor(targetSpeed)) {
      if (speed < targetSpeed) {
        speed = speed + speedChange;
      } else {
        speed = speed - speedChange;
      }
    } else {
      speed = targetSpeed; // reset to a whole number
    }
    z = z + speed;
    if (z > maxZ) {
      z = minZ;
      x = random(-maxX, maxX);
      y = random(-maxY, maxY);
    }
  }

  void show() {
    fill(255);
    noStroke();
    pushMatrix();
    translate(x, y, z);
    box(10);
    // sphere(5);
    popMatrix();
  }
}
