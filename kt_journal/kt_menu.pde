class IContextMenu {
  String[] options;
  float diam, textdiam;
  int w, h;
  int x, y;

  ContextMenu (PGraphics _pg, int Width, int Height, String[] _options) {
    super (_pg);
    w = Width;
    h = Height;
    options = _options;
    diam = min(w, h) * 0.8;
    textdiam = diam/2.75;

    //set_hndl_active(true);
  }

  void updateMask () {
    pg_mask.beginDraw();
    pg_mask.background(transparentColor);
    pg_mask.fill(opaqueColor);
    pg_mask.ellipse(x, y, diam+3, diam+3);
    pg_mask.fill(transparentColor);
    pg_mask.ellipse(x, y, 50, 50);
    pg_mask.endDraw();
  }

  void initial_display() {
    pg.beginDraw();
    pg.background(transparentColor);
    pg.textAlign(CENTER, CENTER);
    pg.noStroke();
    pg.smooth();
    pg.fill(125);
    pg.ellipse(x, y, diam+3, diam+3);
    float op = options.length/TWO_PI;
    for (int i=0; i<options.length; i++) {
      float s = i/op-PI*0.125;
      float e = (i+0.98)/op-PI*0.125;
      pg.fill(255, 255, 0);
      pg.arc(x, y, diam, diam, s, e);
    }

    pg.fill(0);
    for (int i=0; i<options.length; i++) {
      float m = i/op;
      pg.text(options[i], x+cos(m)*textdiam, y+sin(m)*textdiam);
    }

    pg.fill(transparentColor);
    pg.ellipse(x, y, 50, 50);
    pg.endDraw();
  }

  void activeDisplay() {
    pg.beginDraw();
    pg.background(transparentColor);
    pg.textAlign(CENTER, CENTER);
    pg.noStroke();
    pg.smooth();
    pg.fill(125);
    pg.ellipse(x, y, diam+3, diam+3);

    float mouseTheta = atan2(mouseY-y, mouseX-x);
    float piTheta = mouseTheta>=0?mouseTheta:mouseTheta+TWO_PI;
    float op = options.length/TWO_PI;

    float mouseRadius = sqrt(sq(mouseY-y) + sq(mouseX-x));

    selected = -1;
    for (int i=0; i<options.length; i++) {
      float s = i/op-PI*0.125;
      float e = (i+0.98)/op-PI*0.125;
      if (piTheta>= s && piTheta <= e && mouseRadius > 25 && mouseRadius <= diam/2) {
        //println (mouseRadius);
        pg.fill(0, 0, 255);
        selected = i;
      } else {
        pg.fill(255, 255, 0);
      }
      pg.arc(x, y, diam, diam, s, e);
    }

    pg.fill(0);
    for (int i=0; i<options.length; i++) {
      float m = i/op;
      pg.text(options[i], x+cos(m)*textdiam, y+sin(m)*textdiam);
    }

    pg.fill(transparentColor);
    pg.ellipse(x, y, 50, 50);
    pg.endDraw();
  }

  void hideMenu () {
    set_hidden(true);
  }

  void showMenu (int _x, int _y) {
    x = _x;
    y = _y;
    set_hidden(false);
  }

  void action_OnClick (int _mButton) {
    println ("mouseButton = ", _mButton);
    if (_mButton == LEFT) {
      hideMenu();
      selected = get_selected();
      if (selected>-1) {
        println(options[selected] + " (option " + selected + ") selected.");
        //println(mouseButton);
      }
    }
  }

    void MouseLeft () {

    }
  class CtxMenuAction extends IWorker {
    void action (int action_id) {
      switch (action_id) {
        case 1 : do_selected_action ();
                 hide_all ();
                 break;
        case 2 : break; // do nothing for RIGH CLICK
        case 3 : update_appearance ();
        default: break; // do nothing
      }
    }

    void do_selected_action () {
      // FIXME: figure out which item are selected and do corresponding action
    }

    void update_appearance () {
      // FIXME: check if 
    }
  }
}
