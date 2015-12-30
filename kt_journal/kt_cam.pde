// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480, 30);
  cam.start();
}

void draw() {
  if (cam.available()){
    cam.read();
  }
  image(cam, 0,0);
}

void keyReleased() {
  if (key == ENTER) {
    // save recorded video
    
  } else if (key == ESC) {
    // discard video
    cam.stop();
  }
}