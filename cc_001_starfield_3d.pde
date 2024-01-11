float speed = 10, targetSpeed = 100;
float minSpeed = 10, maxSpeed = 200;
float speedChange = 0.0005;
int displayInfo = 1; // -1 hides info, 1 shows it (toggled with 'f')
float maxZ = 1000;
float minZ = -maxZ*5;
float maxX = width * 40;
float maxY = height * 40;
Star[] stars = new Star[500]; // an array to hold initial stars
Star[] morestars = new Star[10]; // stars to be added each time "+" is pressed
Star[] tempstars;
PFont f;
StringList welcomeText;

void setup() {

  welcomeText = new StringList();
  welcomeText.push("Welcome to my version of The Coding Train's first ever coding challenge!");
  welcomeText.push("I've re-implemented the 2D starfield in Processing in 3D and added some controls.");
  welcomeText.push("You can find the code at github.com/davenewt/TCT-CC-001-Starfield");
  welcomeText.push("Below are the buttons you can press, and some live info!");

  fullScreen(P3D);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  f = createFont("Courier", 16, true);
}

void keyReleased() {
  if (keyCode == 73) { // 'i'
    displayInfo *= -1;
  } else if (keyCode == 40) { // UP ARROW
    if (targetSpeed >= minSpeed + 10) {
      targetSpeed -= 10;
    } else {
      targetSpeed = minSpeed;
    }
  } else if (keyCode == 38) { // DOWN ARROW
    if (targetSpeed <= maxSpeed - 10) {
      targetSpeed += 10;
    } else {
      targetSpeed = maxSpeed;
    }
  } else if (keyCode == 61) { // '+' (plus)
    // ADD STARS
    // Populate a separate array with new star objects to be added.
    for (int j = 0; j < morestars.length; j++) {
      morestars[j] = new Star();
      morestars[j].z = minZ; // new stars should be in the distance so they don't suddenly appear!
    }
    // add the new stars to the rendered stars array.
    /* https://processing.org/reference/concat_.html
     When using an array of objects, the data returned from the function
     must be cast to the object array's data type. For example:
     SomeClass[] items = (SomeClass[]) concat(array1, array2).
     */
    // create a temp array the combined length of stars + morestars
    tempstars = new Star[stars.length + morestars.length];
    // concat the two populated arrays and cast (Star[]) to an object of type Star[]
    Star[] tempstars = (Star[]) concat(stars, morestars);
    // replace the rendered stars array with the new longer array!
    stars = tempstars;
  } else if (keyCode == 45) { // '-' (minus)
    // REMOVE STARS
    if (stars.length > 10) { // setting an arbitrary 10 stars minimum
      if (stars.length > 19) {
        for (int i = 0; i < 10; i++) {
          stars = (Star[]) shorten(stars);
        }
      } else {
        float diff = stars.length - 10;
        for (int i = 0; i < diff; i++) {
          stars = (Star[]) shorten(stars);
        }
      }
    }
  }
  println("Key: "+keyCode+"  Speed: "+speed+"  Stars: "+stars.length);
}

void draw() {
  background(0);
  //lights(); // not necessary?

  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }

  // Show/hide info if 'f' pressed [see keyReleased() function above]
  if (displayInfo == 1) {
    pushMatrix();
    textSize(20);
    textMode(SHAPE);
    textAlign(LEFT);
    textFont(f, 18);
    fill(255);

    int m = millis(); // milliseconds since the sketch started running
    int secs = floor(m/1000); // convert to plain seconds
    int lineToShow = floor(secs/10); // secs/x, where x = number of seconds to display each line of info for.
    if (lineToShow < 0) {
      lineToShow = 0;
    } else if (lineToShow > welcomeText.size()-1) {
      lineToShow = welcomeText.size()-1;
    }
    String firstLine = welcomeText.get(lineToShow);
    String displayText = firstLine + "\n" + "[i] hide/show this. [Up/Down arrows] speed. [+/-] stars.\n" +
      "FPS: " + floor(frameRate) +
      "  Stars: "+stars.length +
      "  TargetSpeed: "+floor(targetSpeed) +
      "  Speed: "+floor(speed);
    text(displayText, 50, height-100, 0);  // Specify a z-axis value
    popMatrix();
  }
}
