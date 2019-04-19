// CSci-5609 Project
import controlP5.*;
import org.gicentre.geomap.*;


ControlFrame cf;
ControlP5 cp5;

Chart myChart;
boolean toggleValue;
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
float zoom = 6;


// Temp values;
//String str;

void settings() {
  //fullScreen();
  size(1600,800, P3D);  // Use the P3D renderer for 3D graphics
  smooth(4);
}


void setup() {
  cf = new ControlFrame(this, 400, 800, "Controls");
  surface.setLocation(420, 10);
  
  for (int i = 0; i <8; i++){
    hurs[i] = new Hurricane();
  
  }
  // ================== Set up Map ========================
  
  geoMap = new GeoMap(this);  // Create the geoMap object.
  //geoMap = new GeoMap(-2500,-1500,1600*7,800*7,this);
  geoMap.readFile("world");   // Read shapefile.
  

  //================== zoom in/out ========================
  xo=420;
  yo=240;
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
  
  //====================Graph Chart============================
 /*
  cp5 = new ControlP5(this);
  myChart = cp5.addChart("dataflow")
               .setPosition(50, 50)
               .setSize(1600, 700)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(40))
               ;

  myChart.addDataSet("incoming");
  myChart.setData("incoming", new float[100]);

*/
  
  
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
  
  toggleValue = cf.getToggleValue();
    //====================Swtich button=============
   //probably we can insert a graph or something for this

   pushMatrix();
  if(toggleValue){
      
    
      translate(50,30); // the location for graph to pop out
      zoom=1;
      //insert graph here
      fill(255);
      rect(0,0,1600,600);
    //myChart.push("incoming", (sin(frameCount*0.1)*10));
      
  }
  popMatrix();

 
    //Anthing we don't want to zoom should be placed above
    //==================zoom ========================
  translate(xo,yo);
  scale(zoom);
  translate(-xo,-yo);

  // ================== Draw Map ========================

  stroke(220);              // Boundary colour
  
strokeWeight(1);
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
  if (key == 'r'){
      zoom = 6;
    }else if (key == 'a'){
      zoom = 1;
    }
  if (key == CODED){
    if (keyCode == UP){
      zoom += .1;
    }else if (keyCode == DOWN){
      zoom -= .1;
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
