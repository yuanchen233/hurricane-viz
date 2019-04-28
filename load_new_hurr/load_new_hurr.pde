import java.util.List;
import java.util.ArrayList;



List<Hurricane> hurs = new ArrayList<Hurricane>();

void settings() {
  size(1000,800);
}

void setup() {

  int year;
  Table track = loadTable("hurdat3.csv"); 
  Table this_track = new Table();
  PVector[] track_points;
  Hurricane new_hurr = new Hurricane();
  int num = track.getRowCount();
  for (int k = 0; k < 500;k++){
    String name = track.getString(0,1).replaceAll("\\s","");
    
    String year_str = track.getString(0,0);
    int isYear = track.getInt(0,0);
    //println("hi");
    String strX, strY;
    float x, y;
  
    if(isYear == 0){
      if (new_hurr.track != null){
        track_points = new PVector[new_hurr.track.getRowCount()];
            for (int i = 0; i < new_hurr.track.getRowCount(); i++) {
              strX = new_hurr.track.getString(i, 4);
              strY = new_hurr.track.getString(i, 5);
              x = Float.parseFloat(strX.substring(0,(strX.length()-1)));
              y = Float.parseFloat(strY.substring(0,(strY.length()-1)));
              print(x,y);
              
              track_points[i] = new PVector(x,  y);

              }
      //println(track_points.length);
      new_hurr.points = track_points;
      hurs.add( new_hurr );
      
      
      }
      
      
      new_hurr.name = name;
      new_hurr.track = new Table();
      new_hurr.year = get_year(year_str);
      
  println(k, "/",name, new_hurr.year, isYear);
  
      //println(new_hurr.year);
      // create a new hurr
    
    } else {

      new_hurr.track.addRow(track.getRow(0));
    }
    track.removeRow(0);
  }
 
 
 
 
 println(hurs.get(0).points.length);
 
 
 
}


void draw() {
  background(0);  // Ocean colour
  stroke(250);              // Boundary colour

  

int last;
float x,y;
int this_year = 1851;
float xx=10,yy=10;

      for(Hurricane temp: hurs){
    rect(xx,yy,50,50);
    
        last = temp.points.length;
        beginShape();
        for (int i = 0; i < last; i+=1){
          if (temp.points[i] != null) {
            //println(track_points[i].x,track_points[i].y);
              x = temp.points[i].x;
              y = temp.points[i].y;
              //println(x,y);
              x = (180-x)*width/360;
              y = (85-y) * height/180;
              
              if(temp.getYear() == this_year){
                curveVertex(x,y);
              }
          }
        }
        endShape();
      xx+=1;
      yy+=1;
      }




}

int get_year(String year_str){

  char c;
  int year = 0;
  c = year_str.charAt(year_str.length() - 1);
  year += Character.getNumericValue(c);
  c = year_str.charAt(year_str.length() - 2);
  year += Character.getNumericValue(c) * 10;
  c = year_str.charAt(year_str.length() - 3);
  year += Character.getNumericValue(c) * 100; 
  c = year_str.charAt(year_str.length() - 4);
  year += Character.getNumericValue(c) * 1000;
  return year;
}
