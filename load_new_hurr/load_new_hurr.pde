import java.util.List;
import java.util.ArrayList;



List<Hurricane> hurs2 = new ArrayList<Hurricane>();

void settings() {
  size(1500,1000);
}

void setup() {

  Table track = loadTable("hurdat3.csv");
  int num = track.getRowCount();
  
  for (int k = 0; k < num;k++){
    
    String name = track.getString(0,1).replaceAll("\\s","");
    
    String year_str = track.getString(0,0);
    int isYear = track.getInt(0,0);  
    if(isYear == 0){
      
      Hurricane new_hurr = new Hurricane();
      new_hurr.name = name;
      new_hurr.track = new Table();
      new_hurr.year = get_year(year_str);
      hurs2.add(new_hurr);

    } else {
      hurs2.get(hurs2.size() - 1).track.addRow(track.getRow(0));
    }
    
    track.removeRow(0);
  }

  for(Hurricane temp: hurs2){
    String strX, strY;
    float x, y;
    PVector[] points = new PVector[temp.track.getRowCount()];
    for (int i = 0; i < temp.track.getRowCount(); i++) {

      //print(temp.track.getRowCount());
      
      strX = temp.track.getString(i, 4);
      strY = temp.track.getString(i, 5);
      y = Float.parseFloat(strX.substring(0,(strX.length()-1)));
      x = Float.parseFloat(strY.substring(0,(strY.length()-1)));
      //print(x,y);
              
        points[i] = new PVector(x,  y);

      }
    temp.points = points;
  }
}


void draw() {
  background(0);  // Ocean colour
  stroke(250);              // Boundary colour

  noLoop();
noFill();
  int last;
  float x,y;
  int this_year = 1851;


      for(Hurricane temp: hurs2){
    
    
        last = temp.points.length;
        //println(last);
        beginShape();
        for (int i = 0; i < last; i+=1){
          if (temp.points[i] != null) {
            //println(track_points[i].x,track_points[i].y);
              x = temp.points[i].x;
              y = temp.points[i].y;
              x = (180-x)*width/360;
              y = (85-y) * height/180;
               //println("curveVertex(",x*2-400,',',y*2-400,");");
                

                curveVertex(x,y);
              
          }
        }
        endShape();

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
