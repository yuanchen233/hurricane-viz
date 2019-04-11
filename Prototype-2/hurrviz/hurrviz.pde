// CSci-5609 Project

import org.gicentre.geomap.*;

PVector[] track_points;
int displayMode = 1;
float lerpAmount = 0;
boolean lerpit = true;
int last;
int factor = 5;

GeoMap geoMap;




void setup() {
  size(1600,800, P3D);  // Use the P3D renderer for 3D graphics

  // ================== Set up Map ========================
  
  geoMap = new GeoMap(this);  // Create the geoMap object.
  geoMap.readFile("world");   // Read shapefile.
  
  // ================== End Map ========================
  
  
  Hurricane albert = new Hurricane();
  
  // load in .csv files
  albert.track = loadTable("HurricaneData/2014/ArthurData2014.csv", "header"); 

  // TODO: create object based on paras
  albert.track.removeRow(0);
  albert.track.removeRow(0);
  track_points = new PVector[albert.track.getRowCount()];
  
  for (int i = 0; i < albert.track.getRowCount(); i++) {
    track_points[i] = new PVector(albert.track.getFloat(i, 4), 
                                  albert.track.getFloat(i, 2));
  }

}

void draw() {
  
  background(0);  // Ocean colour
  
  // ================== Draw Map ========================

  stroke(220);              // Boundary colour

  // Draw entire world map.
  fill(180);        // Land colour
  geoMap.draw();              // Draw the entire map.

  // Find the country at the mouse position and draw it in different colour.
  int id = geoMap.getID(mouseX, mouseY);
  if (id != -1)
  {
    fill(100);      // Highlighted land colour.
    geoMap.draw(id);
  }


  // ================== End Map ========================
float x,y;

stroke(#1087E5);

last = track_points.length-1;
//println(track_points[0].x,track_points[0].y);
//println(track_points[last].x,track_points[last].y);
  noFill();
  smooth(4);
  beginShape();
  for (int i = 0; i < last; i+=10){
  	if (track_points[i] != null) {
      //println(track_points[i].x,track_points[i].y);
        x = track_points[i].x;
        println(x);
        y = track_points[i].y;
        x = (180-x)*1600/360;
        y = (90 - y) * 800/180;
        
        curveVertex(x,y);
        
    }
  }
  endShape();
noLoop();
}
