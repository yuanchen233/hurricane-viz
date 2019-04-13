// CSci-5609 Project

import org.gicentre.geomap.*;

PFont myFont1;
PFont myFont2;
int displayMode = 1;
float lerpAmount = 0;
boolean lerpit = true;
int last;
int factor = 5;
String[] filenames;
Hurricane[] hurs = new Hurricane[8];
String path;
GeoMap geoMap;
float xo,yo;
float zoom = 2;

// Temp values;
//String str;

void settings() {
  //fullScreen();
  size(1600,800, P3D);  // Use the P3D renderer for 3D graphics
  smooth(4);
}


void setup() {

  
  
  myFont1 = createFont("Georgia", 28);
  
  myFont2 = createFont("Georgia", 24);
  
  
  
  for (int i = 0; i <8; i++){
    hurs[i] = new Hurricane();
  
  }


  // ================== Set up Map ========================
  
  geoMap = new GeoMap(this);  // Create the geoMap object.
  //geoMap = new GeoMap(-2500,-1500,1600*7,800*7,this);
  geoMap.readFile("world");   // Read shapefile.
  
  //================== zoom in/out ========================
 xo = 0;
  yo = 0;
  smooth();
  noStroke();
  
  
  // ================== Read File ========================
  
  path = sketchPath()+"/data/HurricaneData/2014";
  filenames = listFileNames(path);
  //printArray( filenames);

  // ================== Load H ========================
  int t = 0;
  PVector[] track_points;
  for(String str:filenames){


  if (str.charAt(str.length() - 1) == 'v'){
  
    Hurricane albert = new Hurricane();
    
    // load in .csv files
    albert.track = loadTable(path + '/' + str, "header"); 
  
    // TODO: create object based on paras
    albert.track.removeRow(0);
    albert.track.removeRow(0);
    track_points = new PVector[albert.track.getRowCount()];
    
    for (int i = 0; i < albert.track.getRowCount(); i++) {
      track_points[i] = new PVector(albert.track.getFloat(i, 4), 
                                    albert.track.getFloat(i, 2));
    }
    albert.points = track_points;
    hurs[t] = albert;

    ++t;
  }
  
  
}

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
  
    // ================== Draw Panel ========================
  strokeWeight(1.0);
  noStroke();
  fill(250,250,250,75);
  rect(25, 400, width/6, height/3,18,18,18,18);
  
  fill(250,250,250,95);
  textFont(myFont1);
  textAlign(CENTER, CENTER);
  text("Hurricane Info", width/10, height/2.5+height/8);
  textFont(myFont2);
  text("Albert", width/10, height/2.5+height/8*1.5);
  text("2014/03 - 2014 - 08", width/10, height/2.5+height/8*2);
  text("Damage: $999", width/10, height/2.5+height/8*2.5);
    //==================zoom ========================
  translate(xo,yo);
  scale(zoom);
  
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
  

  


  // ================== Draw Hurr ========================
float x,y;


strokeWeight(1.0);
strokeJoin(ROUND);

  noFill();
  
  for(Hurricane temp: hurs){

    if (temp == hurs[0]){
      strokeWeight(2.0);
      stroke(#F57474,250);
    } else { stroke(#9CD5E0,100);}
   
    
    last = temp.points.length-1;
    beginShape();
    for (int i = 0; i < last; i+=10){
    	if (temp.points[i] != null) {
        //println(track_points[i].x,track_points[i].y);
          x = temp.points[i].x;
          y = temp.points[i].y;
          x = (180-x)*width/360;
          y = (85-y) * height/180;
          
          curveVertex(x,y);
          
      }
    }
    endShape();
  
  }
  


}

void keyPressed(){
  if (key == CODED){
    if (keyCode == UP){
      zoom += .03;
    }else if (keyCode == DOWN){
      zoom -= .03;
    }
    
    if (key == ' '){
      xo = 0;
      yo = 0;
      zoom = 2;
    }
  }
}
