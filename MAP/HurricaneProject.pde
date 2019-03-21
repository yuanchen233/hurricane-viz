import org.gicentre.geomap.*;
 
GeoMap geoMap;// Declare the geoMap object.
//GeoMap geoMapUS;// Declare the geoMap object.

void setup()
{
  size(1200, 600);  
  geoMap = new GeoMap(this);  // Create the geoMap object.
  geoMap.readFile("world");   // Read shapefile.
  
    // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(18);

  // Display the first 5 rows of attributes in the console.
  geoMap.writeAttributesAsTable(5);
  
 /* geoMapUS = new GeoMap(this);  // Create the geoMap object.
  geoMapUS.readFile("usContinental");   // Read shapefile.
  */
}


void draw()
{
   background(0, 119,190);  // Ocean colour
  stroke(0, 40);              // Boundary colour

  // Draw entire world map.
  //fill(206, 173, 146);        // Land colour
  fill(0, 128, 0);
  geoMap.draw();              // Draw the entire map.

  // Query the country at the mouse position.
  int id = geoMap.getID(mouseX, mouseY);
  if (id != -1)
  {
    fill(180, 120, 120);
    geoMap.draw(id);

    String name = geoMap.getAttributeTable().findRow(str(id),0).getString("NAME");    
    fill(0);
    text(name, mouseX+5, mouseY-5);
  }
}

/*
void drawus()
{
  background(202, 226, 245);  // Ocean colour
  fill(206,173,146);          // Land colour
  stroke(0,40);               // Boundary colour
    
  geoMapUS.draw();              // Draw the entire map.
   
  noLoop();
}
*/
