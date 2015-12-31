class UIStack {
  PGraphics pg_desk;
  Desk desk;
  ArrayList<UIObj> ui_stack = new ArrayList<UIObj>();
  int hndl_active_idx = -1;
  int width = 800;
  int height= 600;
  UIStack (int _w, int _h) {
    width = _w;
    height = _h;
    pg_desk = createGraphics (width, height);
    desk = new Desk(pg_desk);
    push(desk);
  }

  void push(UIObj _obj) {
    ui_stack.add(_obj);
    hndl_active_idx = ui_stack.size()-1;
  }

  UIObj pop () {
    UIObj tmp = ui_stack.remove(0);
    hndl_active_idx = ui_stack.size()-1;
    return tmp;
  }

  void updateActive() {
    for (UIObj ui_obj : ui_stack) {
      ui_obj.set_hndl_active(false);
    }
    hndl_active_idx = 0;

    for (int i = ui_stack.size() - 1; i >= 0; i--) {
      UIObj tmp_ui = ui_stack.get(i);
      if (tmp_ui.is_mouseHovered()) {
        tmp_ui.set_hndl_active(true);
        hndl_active_idx = i;
        break;
      }
    }
    //println ("Active ", hndl_active_idx);
  }

  void draw() {
    for (int i = 0; i < ui_stack.size(); i++) {
      UIObj tmp_ui = ui_stack.get(i);
      tmp_ui.draw();
      image(tmp_ui.pg, 0, 0);
    }
  }

  void mouseClicked (int _mouseButton) {
    println (_mouseButton);
    updateActive();
    if (hndl_active_idx > -1) {
      UIObj tmp_ui = ui_stack.get(hndl_active_idx);
      tmp_ui.mouseClicked (_mouseButton);
    }
  }

  void mouseHovering () {
    updateActive();
  }
}