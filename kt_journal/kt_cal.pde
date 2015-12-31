import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

class KittyCal extends UIObj {
  Date date;
  SimpleDateFormat sdf;
  Calendar cal;

  int cal_cols=7;
  int cal_rows=6;
  int cell_w = 20, cell_h = 20;
  int w = cell_w * cal_cols;
  int h = cell_h * cal_rows;
  int x;
  int y;

  Cell[][] grid;
  Cell[][] gridDays;

  String date_;

  int _date;
  int _month;
  int _year;

  KittyCal(PGraphics _pg, int _x, int _y) {
    super (_pg);
    x = _x;
    y = _y;
    grid=new Cell[cal_cols][cal_rows];
    for (int i=0; i<cal_cols; i++) {
      for (int j=0; j<cal_rows; j++) {
        grid[i][j]=new Cell(x+i*cell_w, y+j*cell_h, cell_w, cell_h);
      }
    }
    cal = Calendar.getInstance();
    cal.setFirstDayOfWeek(Calendar.MONDAY);
    _date=1;
    _month=4;
    _year=2016;
    sdf = new SimpleDateFormat("M/d/y");
    date_=(nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year);
    //println((nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year));
    cal.set(_month, _date, _year);
    try {
      date = sdf.parse(date_);
    } 
    catch(ParseException e) {
      println(e);
    }
    cal.setTime(date);

    gridDays=new Cell[cal_cols][cal_rows];
    for (_date=1; _date<=cal.getActualMaximum(Calendar.DAY_OF_MONTH); _date++) {
      date_=(nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year);
      //println((nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year));
      cal.set(_month, _date, _year);
      try {
        date = sdf.parse(date_);
      } 
      catch(ParseException e) {
        println(e);
      }
      cal.setTime(date);
      int day =cal.get(Calendar.DAY_OF_WEEK);
      int j;
      j=cal.get(Calendar.WEEK_OF_MONTH);
      int i = ((day - 1) + 7) % 7;
      i = i == 0 ? 7 : i;
      //println("day = " + day + " i = "+i+" j= "+j);
      gridDays[i-1][j-1]=new Cell(x +(i-1)*cell_w, y+(j-1)*cell_h, cell_w, cell_w);
    }

    //println("Day Of Week: " + cal.get(Calendar.DAY_OF_WEEK));
    //println("Day Of Month: " + cal.get(Calendar.DAY_OF_MONTH));
    //println("Week Of Month: " + cal.get(Calendar.WEEK_OF_MONTH));
  }

  void updateMask () {
    pg_mask.beginDraw();
    pg_mask.background(transparentColor);
    pg_mask.fill(opaqueColor);
    pg_mask.rect(x, y, w, h);
    pg_mask.endDraw();
  }

  void initial_display () {
    pg.beginDraw();
    pg.background(transparentColor);
    for (int i=0; i<cal_cols; i++) {
      for (int j=0; j<cal_rows; j++) {
        grid[i][j].display();
      }
    }

    for (_date=1; _date<=cal.getActualMaximum(Calendar.DAY_OF_MONTH); _date++) {
      date_=(nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year);
      //println((nf(_month,2,0)+"/"+nf(_date,2,0)+"/"+_year));
      cal.set(_month, _date, _year);
      try {
        date = sdf.parse(date_);
      } 
      catch(ParseException e) {
        println(e);
      }
      cal.setTime(date);
      int day =cal.get(Calendar.DAY_OF_WEEK);
      int i = ((day - 1) + 7) % 7;
      i = i == 0 ? 7 : i;
      int j;
      j=cal.get(Calendar.WEEK_OF_MONTH);
      //grid[i-1][j-1].display();
      gridDays[i-1][j-1].displayDays(cal.get(Calendar.DAY_OF_MONTH), day == 1);
    }
    pg.endDraw();
  }

  class Cell {
    // A cell object knows about its location in the grid as well as its size with the variables x,y,w,h.
    float x, y;   // x,y location
    float w, h;   // width and height
    float angle; // angle for oscillating brightness

    // Cell Constructor
    Cell(float tempX, float tempY, float tempW, float tempH) {
      x = tempX;
      y = tempY;
      w = tempW;
      h = tempH;
    }
    void display() {
      pg.stroke(0);
      pg.rect(x, y, w, h);
    }//end of display

    void displayDays(int dayTxt, boolean isHoliday) {
      if (isHoliday) pg.fill(255, 0, 0);
      else pg.fill(0);
      pg.stroke(0);
      pg.text(dayTxt, x+4, y+15);
      pg.fill(255);
    }//end of display
  }//end Class Cell

  void action_OnClick (int _mButton) {
    if (_mButton == RIGHT) {
      cal_menu.showMenu (mouseX, mouseY);
    }
  }
}