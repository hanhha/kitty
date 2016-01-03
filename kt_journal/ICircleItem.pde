class ICircleItem extends IObj {
  int D;
  int R;

  ICircleItem (PGraphics _pg, int _X, int _Y, int _D, IWorker _worker) {
    super (_pg, _X, _Y, _D, _D, _worker);
    R = D/2;
    prepareImgMouse();
    prepareImgNoMouse();
    prepareImgInactive();
  }

  void prepareMask () {
    layoutMask = createGraphics (W, H);
    layoutMask.beginDraw();
    layoutMask.background(transparentColor);
    layoutMask.noStroke();
    layoutMask.smooth();
    layoutMask.fill(opaqueColor);
    layoutMask.ellipse(R, R, D, D);
    layoutMask.endDraw();
  }

  void checkMouseInside () {
    mouseInside = (sq(mouseX - centerX) + sq(mouseY - centerY) <= sq(R)) ? true : false;
  }

  void prepareImgMouse () {
    imgMouse = createGraphics (W, H);
    imgMouse.beginDraw();
    imgMouse.background(0);
    imgMouse.textAlign(CENTER, CENTER);
    imgMouse.noStroke();
    imgMouse.smooth();
    imgMouse.fill(125);
    imgMouse.ellipse(R, R, D, D);
    imgMouse.fill(0, 0, 255);
    imgMouse.ellipse(R, R, D-3, D-3);
    imgMouse.fill(0);
    imgMouse.text(text, R, R);
    imgMouse.endDraw();
  }

  void prepareImgNoMouse () {
    imgNoMouse = createGraphics (W, H);
    imgNoMouse.beginDraw();
    imgNoMouse.background(0);
    imgNoMouse.textAlign(CENTER, CENTER);
    imgNoMouse.noStroke();
    imgNoMouse.smooth();
    imgNoMouse.fill(125);
    imgNoMouse.ellipse(R, R, D, D);
    imgNoMouse.fill(255, 255, 0);
    imgNoMouse.ellipse(R, R, D-3, D-3);
    imgNoMouse.fill(0);
    imgNoMouse.text(text, R, R);
    imgNoMouse.endDraw();
  }

  void prepareImgInactive () {
    imgInactive = createGraphics (W, H);
    imgInactive.beginDraw();
    imgInactive.background(0);
    imgInactive.textAlign(CENTER, CENTER);
    imgInactive.noStroke();
    imgInactive.smooth();
    imgInactive.fill(125);
    imgInactive.ellipse(R, R, D, D);
    imgInactive.fill(0, 0, 255);
    imgInactive.ellipse(R, R, D-3, D-3);
    imgInactive.fill(0);
    imgInactive.text(text, R, R);
    imgInactive.endDraw();
  }
}
