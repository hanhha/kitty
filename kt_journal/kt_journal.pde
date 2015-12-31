PGraphics pg_cal;
PGraphics pg_cal_menu;
PGraphics pg_menu;

UIStack pg_stack;

ContextMenu menu, cal_menu;
KittyCal cal;


int display_width = 800;
int display_height= 600;
float mx = 0;
float my = 0;
int selected;
String[] options = { "Forward", "Submenu", "Reload", "View Source", 
  "Forward", "Back", "Reload", "View Source" };
String[] cal_options = { "Forward", "Back", "Reload", "View Source" };

void setup () {
  size(800, 600);
  smooth();


  pg_cal_menu = createGraphics (display_width, display_height);
  pg_menu = createGraphics (display_width, display_height);
  pg_cal = createGraphics (display_width, display_height);

  menu = new ContextMenu (pg_menu, 300, 300, options);
  cal_menu = new ContextMenu (pg_cal_menu, 300, 300, cal_options);
  cal = new KittyCal (pg_cal, display_width/2, display_height/2);
  cal.set_hidden (false);

  pg_stack = new UIStack(display_width, display_height);
  pg_stack.push(cal);
  pg_stack.push(menu);
  pg_stack.push(cal_menu);
}

void mouseClicked () {
  pg_stack.mouseClicked(mouseButton);
}

void mouseMoved () {
  pg_stack.mouseHovering();
}
void draw () {
  pg_stack.draw();
}