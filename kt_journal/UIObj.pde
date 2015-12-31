class UIObj {
  boolean hidden = true;
  int selected = -1;
  PGraphics pg, pg_mask, clean_mask;
  boolean hndl_active = false;
  color transparentColor = color(0, 0, 0);
  color opaqueColor = color(255, 255, 255);

  UIObj (PGraphics _pg) {
    pg = _pg;
    pg_mask = createGraphics (_pg.width, _pg.height);
    pg_mask.beginDraw();
    pg_mask.background(transparentColor);
    pg_mask.fill(opaqueColor);
    pg_mask.rect(0, 0, pg_mask.width, pg_mask.height);
    pg_mask.endDraw();
    clean_mask = createGraphics (_pg.width, _pg.height);
    clean_mask.beginDraw();
    clean_mask.background(transparentColor);
    clean_mask.endDraw();
  }

  int get_selected () {
    return selected;
  }

  void set_hidden (boolean _hidden) {
    hidden = _hidden;
  }

  void set_hndl_active (boolean _hndl_active) {
    hndl_active = _hndl_active;
  }

  void draw () {
    if (!hidden) {
      if (hndl_active) {
        activeDisplay();
      } else {
        inactiveDisplay();
      }
    } else {
      clean();
    }
    setMask();
  }

  void setMask () {
    updateMask();
    if (!hidden) {
      pg.mask(pg_mask);
    } else {
      pg.mask(clean_mask);
    }
  }

  void updateMask () {
  }

  void initial_display () {
    ;
  }

  void activeDisplay () {
    initial_display ();
  }

  void inactiveDisplay () {
    initial_display ();
  }

  void clean () {
    pg.beginDraw();
    pg.background(transparentColor);
    pg.endDraw();
  }

  void mouseClicked (int _mouseButton) {
    if (hndl_active) action_OnClick (_mouseButton);
  }

  void action_OnClick (int _mouseButton) {
  }

  boolean is_mouseHovered () {
    if (!hidden) {
      if (pg_mask.get(mouseX, mouseY) == opaqueColor) {
        return true;
      } else {
        return false;
      }
    } else return false;
  }
}