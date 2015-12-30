class ContextMenu {
  String[] options;
  PGraphics pg;
  PGraphics pg_mask;
  color transparentColor;
  float diam, textdiam;
  int selected;
  int w, h;
  int x, y;
  boolean hidden = true;

  ContextMenu (PGraphics _pg, color _transparentColor, int Width, int Height, String[] _options) {
    w = Width;
    h = Height;
    options = _options;
    transparentColor = _transparentColor;
    pg = _pg;
    diam = min(w, h) * 0.8;
    textdiam = diam/2.75;
    pg_mask = createGraphics (pg.width, pg.height);
  }

  int get_selected () {
    return selected;
  }

  void draw() {
    pg_mask.beginDraw();
    pg_mask.background(0);
    pg_mask.fill(255);
    pg_mask.ellipse(x, y, diam+3, diam+3);
    pg_mask.fill(0);
    pg_mask.ellipse(x, y, 50, 50);
    pg_mask.endDraw();

    pg.beginDraw();
    pg.background(transparentColor, 0);
    pg.textAlign(CENTER, CENTER);
    pg.noStroke();
    pg.smooth();
    if (!hidden) {
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
      pg.mask(pg_mask);
    } else {
      pg.endDraw();
    }
  }

  void hideMenu () {
    hidden = true;
  }

  void showMenu (int _x, int _y) {
    x = _x;
    y = _y;
    hidden = false;
  }
}