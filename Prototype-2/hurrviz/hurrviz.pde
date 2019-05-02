// CSci-5609 Project
import controlP5.*;
import org.gicentre.geomap.*;
import org.gicentre.utils.stat.*; 
import java.util.List;
import java.util.ArrayList;

ControlFrame cf;
ControlP5 cp5;

BarChart barChart;
BarChart barChart1;
PFont titleFont,smallFont;
boolean toggleValue;
boolean toggle;
PImage img;
PFont myFont1;
PFont myFont2;
int displayMode = 1;
float lerpAmount = 0;
boolean lerpit = true;
int last;
int factor = 5;
String[] filenames;
List<Hurricane> hurs = new ArrayList<Hurricane>();
List<Hurricane> hurs2 = new ArrayList<Hurricane>();
String path;
GeoMap geoMap;
float xo,yo;
float zoom = 6;
List<Integer> years = new ArrayList<Integer>();

void settings() {
  //fullScreen();
  size(1500,1000, P3D);  // Use the P3D renderer for 3D graphics
  smooth(4);
}

void setup() {
  cf = new ControlFrame(this, 400, 800, "Controls");
  surface.setLocation(420, 10);
    //====================Graph Chart============================
  titleFont = loadFont("Helvetica-22.vlw");
  smallFont = loadFont("Helvetica-12.vlw");
  textFont(smallFont);

  float [] stormsData =new float[] {84,61,71,115, 104, 119, 95,95,93,110,151,137};
  float [] hData = new float[] {42,37,41,52,53,68,62,50,52,64,74,66};
  String [] barLabels = new String[] {"1900-1909","1910-1919","1920-1929","1930-1939","1940-1949",
                                        "1950-1959","1960-1969","1970-1979","1980-1989","1990-1999",
                                      "2000-2009","2010-2018"};
  barChart = new BarChart(this);
  barChart.setData(stormsData);
  barChart.setBarLabels(barLabels);
  barChart.setBarColour(color(200,80,80,100));
  barChart.setBarGap(2); 
  barChart.setValueFormat("###,###");
  barChart.setMinValue(0);
  barChart.setMaxValue(200);
  barChart.showValueAxis(true); 
  barChart.showCategoryAxis(true); 
  
  barChart1 = new BarChart(this);
  barChart1.setData(hData);
  barChart1.setBarLabels(barLabels);
  barChart1.setBarColour(color(200,70,70,130));
  barChart1.setBarGap(2);
  barChart1.setValueFormat("###,###");
  barChart1.setMinValue(0);
  barChart1.setMaxValue(200);
  barChart1.showValueAxis(true); 
  barChart1.showCategoryAxis(true); 
  
  // ================== Set up Map ========================
  
  geoMap = new GeoMap(this);  // Create the geoMap object.
  //geoMap = new GeoMap(-2500,-1500,1600*7,800*7,this);
  geoMap.readFile("world");   // Read shapefile.
  

  //================== zoom in/out ========================
  xo=350;
  yo=300;
  noStroke();

  // ================== Read File ========================
  
  path = sketchPath()+"/data/HurricaneData";
  filenames = listFileNames(path);
  //printArray( filenames);

  // ================== Load recent H ========================
  int t = 0;
  PVector[] track_points;

  for(String str:filenames){
    if (str.charAt(str.length() - 1) == 'v'){
    
      Hurricane new_hurr = new Hurricane();
      
      // load in .csv files
      new_hurr.track = loadTable(path + '/' + str); 
    
      // TODO: create object based on paras
      new_hurr.name = new_hurr.track.getString(0,2);
      new_hurr.year = new_hurr.track.getInt(0,3);
      new_hurr.level = new_hurr.track.getInt(3,6);
      //println(t, new_hurr.name, new_hurr.year);
      
      new_hurr.track.removeRow(0);
      new_hurr.track.removeRow(0);
      new_hurr.track.removeRow(0);
      track_points = new PVector[new_hurr.track.getRowCount()];
      
      for (int i = 0; i < new_hurr.track.getRowCount(); i++) {
        track_points[i] = new PVector(new_hurr.track.getFloat(i, 4), 
                                      new_hurr.track.getFloat(i, 2));
      }
      new_hurr.points = track_points;
      hurs.add( new_hurr );
      ++t;
    } // end if
  } // end for
  
  
    // ================== Load more H ========================
  
  
  
  Table track = loadTable("data/hurdat3.csv");
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
      new_hurr.level = 3;
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
  
  
  
   //=====================NOAA graph as support===================
  img = loadImage("HurrStats.png");


} // end set-up


String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}


void draw() {
  
  background(0);  // Ocean colour
  
  toggleValue = cf.getToggleValue();
  toggle = cf.getToggleValueImage();
    //====================Swtich button=============
   //probably we can insert a graph or something for this
   pushMatrix();
  if(toggleValue){
      
    
      translate(50,30); // the location for graph to pop out
      //insert graph here
      background(255);
      barChart.draw(10,10,width-20,height-50);      
      barChart1.draw(10,10,width-20,height-50);
      
 
      fill(120);
      textFont(titleFont);
      text("Atlantic Basin Storm Totals by Year ", 70,30);
      float textHeight = textAscent();
      textFont(smallFont);
      text("(including subtropical cyclones)  ", 70,30+textHeight);
      text("Tropical Storms", 100,60+textHeight);
      text("Hurricanes", 100,80+textHeight);
      fill(255, 90, 90);
      ellipse(240,55+textHeight,16,16);
      fill(200,70,70,130);
      ellipse(240,75+textHeight,16,16);

      
  }
  
  if(toggle){

      translate(50,30); // the location for graph to pop out
      //insert graph here
      background(255);
      image(img,0,0,width-20,height-50);
      textAlign(LEFT,BOTTOM);
      text("Data graph from gfdl.noaa.",10,height);
  }
  popMatrix();

    //Anthing we don't want to zoom should be placed above
    //==================zoom ========================
  translate(xo,yo);
  scale(zoom);
  translate(-xo,-yo);

  // ================== Draw Map ========================

  stroke(71.37);              // Boundary colour
  if(!toggleValue &!toggle){       // if toggle is off 
 strokeWeight(1);
  // Draw entire world map.
  fill(85.88);        // Land colour
  geoMap.draw();              // Draw the entire map.
/*
  // Find the country at the mouse position and draw it in different colour.
  int id = geoMap.getID(mouseX, mouseY);
  if (id != -1)
  {
    fill(100);      // Highlighted land colour.
    geoMap.draw(id);
  }
  */
      textAlign(LEFT,BOTTOM);
      text("Hold UP or DOWN on keyboard or using mouse scrolling to zoom. Press LEFT to reset view. Press Right to view the whole map."
      ,10,height);
  // ================== Draw Hurr ========================
float x,y;

strokeWeight(1.0);
strokeJoin(ROUND);

List<Integer> t_years = new ArrayList<Integer>(years);

  noFill();
    for (int this_year:t_years){
      for(Hurricane temp: hurs2){

          //stroke(cf.get_color(this_year),170);
          
            int t1 = this_year - 1900;
            int j = t1 / 10;
            float k = t1 - j * 10;
            k = k / 15.0;
            stroke( lerpColor(cf.get_color(this_year) , color(255),k), 170);
          
          
          
          
          strokeWeight(0.7+temp.level/8.0);

        last = temp.points.length-1;
        beginShape();
        for (int i = 0; i < last; i+=1){
          if (temp.points[i] != null) {
            //println(track_points[i].x,track_points[i].y);
              x = temp.points[i].x;
              y = temp.points[i].y;
              x = (180-x)*width/360;
              y = (85-y) * height/180;
              if(temp.getYear() == this_year){
                curveVertex(x,y);
              }
          }
        }
        endShape();
      
      }
    }
  }
}


void keyPressed(){

  if (key == CODED){
    if (keyCode == UP){
      zoom += .1;
    }else if (keyCode == DOWN){
      zoom -= .1;
    }else if(keyCode == LEFT){
     zoom = 6;
    }else if (keyCode == RIGHT){
      zoom = 1;
    }
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e == 1.0){
    zoom += .1;
  }else if(e == -1.0){
    zoom -= .1;
  }
}

void add_year(int year){
  if (years.contains(year)){
    //years.remove(year);
  } else {
    years.add(year);
  }

}

void remove_year(int year){
  int i = years.indexOf(year);
  
  if (i != -1){
    years.remove(i);
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
