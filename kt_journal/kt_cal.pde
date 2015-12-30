import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

class KittyCal {
  Date date;
  SimpleDateFormat sdf;
  Calendar cal;
  PGraphics pg;
  PGraphics pg_mask;
  color transparentColor;
  
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

  KittyCal(PGraphics _pg, color _transparentColor, int _x, int _y) {
    x = _x;
    y = _y;
    transparentColor = _transparentColor;
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
    println((nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year));
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
      println((nf(_month, 2, 0)+"/"+nf(_date, 2, 0)+"/"+_year));
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
      println("day = " + day + " i = "+i+" j= "+j);
      gridDays[i-1][j-1]=new Cell(x +(i-1)*cell_w, y+(j-1)*cell_h, cell_w, cell_w);
    }

    //println("Day Of Week: " + cal.get(Calendar.DAY_OF_WEEK));
    //println("Day Of Month: " + cal.get(Calendar.DAY_OF_MONTH));
    //println("Week Of Month: " + cal.get(Calendar.WEEK_OF_MONTH));
    //println("Days Of Month: " + cal.getActualMaximum(Calendar.DAY_OF_MONTH));
    pg = _pg;
    pg_mask = createGraphics (pg.width, pg.height);
  }

  void draw() {
    pg_mask.beginDraw();
    pg_mask.background(0);
    pg_mask.fill(255);
    pg_mask.rect(x, y, w, h);
    pg_mask.endDraw();
    
    pg.beginDraw();
    pg.background(transparentColor, 0);
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
    pg.mask (pg_mask);
  }//end of draw

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
}