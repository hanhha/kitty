class IObj {
  int centerX, centerY;
  int W, H;
  PGraphics offScreen, imgMouse, imgNoMouse, imgInactive, img;
  PGraphics layoutMask;
  boolean hidden = true;
  boolean active = false;
  color transparentColor = color(0, 0, 0);
  color opaqueColor = color(255, 255, 255);
  int offsX, offsY;
  String text;
  IWorker worker;
  booelan mouseInside, pmouseInside;

  IObj (PGraphics _pg, int _X, int _Y, int _W, int _H, IWorker _worker) {
    offScreen = _pg;
    centerX = _X; 
    centerY = _Y;
    H = _H; 
    W = _W;
    offsX = centerX - W/2;
    offsY = centerY - H/2;
    prepareMask();
    worker = _worker;
  }

  void prepareMask () {
    layoutMask = createGraphics (W, H);
    layoutMask.beginDraw();
    layoutMask.background(transparentColor);
    layoutMask.fill(opaqueColor);
    layoutMask.rect(0, 0, W/2, H/2);
    layoutMask.endDraw();
  }

  void set_hidden (boolean _hidden) {
    hidden = _hidden;
    active = _hidden ? false : active;
  }

  void set_active (boolean _active) {
    active = _active;
  }

  boolean isAvail () {
    return hidden | !active ? false : true;
  }

  boolean isUnderMouse () {
    return isAvail ? mouseInside : false;
  }

  void updateMouseInside () {
    pmouseInside = mouseInside;
    checkMouseInside();
  }

  void checkMouseInside () {
    mouseInside = false;
  }

  void drawImgMouse () {
    img = imgMouse;
  }

  void drawImgNoMouse () {
    img = imgNoMouse;
  }

  void drawImgInactive () {
    img = imgInactive;
  }

  void draw () {
    if (!hidden) {
      if (active) {
        if (isUnderMouse()) drawImgMouse();
        else drawImgNoMouse();
      } else {
        drawImgInactive ();
      }
      img.mask(layoutMask);
      offScreen.image(img, offsX, offsY);
    }
  }

  void mouseMoved () {
    if (isAvail()) {
      updateMouseInside ();
      if (mouseLeft ()) onMouseLeft (3);
      if (mouseCame ()) onMouseCame (4);
    }
  }

  boolean mouseLeft () {
    return (!mouseInside && pmouseInside)l
  }

  boolean mouseCame () {
    return (!pmouseInside && mouseInside);
  }

  void mouseClicked (int _mouseButton) {
    if (isUnderMouse()) onMouseClicked (_mouseButton);
  }

  void onMouseClicked (int action_tag) {
    worker.action(action_tag == LEFT ? 1 : action_tag == RIGHT ? 2 : 0);
  }

  void onMouseLeft (int action_tag) {
    worker.action(action_tag);
  }

  void onMouseCame (int action_tag) {
    worker.action(action_tag);
  }
}
