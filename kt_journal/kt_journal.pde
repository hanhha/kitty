PGraphics pg_cal;
PGraphics pg_menu;

ContextMenu menu;
KittyCal cal;

color backgroundColor = color (125,125,125);
color transparentColor = color (125);

int display_width = 800;
int display_height= 600;
float mx = 0;
float my = 0;
int selected;
String[] options = { "Forward", "Submenu", "Reload", "View Source", 
  "Forward", "Back", "Reload", "View Source" };

void setup () {
  size(800, 600);
  smooth();

  pg_menu = createGraphics (display_width, display_height);
  pg_cal = createGraphics (display_width, display_height);
  menu = new ContextMenu (pg_menu, transparentColor, 300, 300, options);
  cal = new KittyCal (pg_cal, transparentColor, display_width/2, display_height/2);
}

void mousePressed () {
  if (mouseButton == LEFT) {
    menu.hideMenu();
    selected = menu.get_selected();
    if (selected>-1) {
      println(options[selected] + " (option " + selected + ") selected.");
    }
  } else if (mouseButton == RIGHT) {
    menu.showMenu (mouseX, mouseY);
  }
}

void draw () {
  background (backgroundColor);
  cal.draw();
  menu.draw();
  image(pg_cal, 0, 0);
  image(pg_menu, 0, 0);
}