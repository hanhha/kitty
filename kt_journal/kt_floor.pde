class Desk extends UIObj {
  Desk (PGraphics _pg) {
    super (_pg);
    hidden = false;
  }

  void initial_display() {
    pg.beginDraw();
    pg.background(color(125, 125, 125));
    pg.endDraw();
  }

  boolean is_mouseHovered () {
    return true;
  }

  void action_OnClick (int _mButton) {
    //println ("mouseButton = ", _mButton);
    if (_mButton == LEFT) {
      menu.hideMenu();
      cal_menu.hideMenu();
      println("Nothing done.");
    } else if (_mButton == RIGHT) {
      menu.showMenu(mouseX, mouseY);
    }
  }
}