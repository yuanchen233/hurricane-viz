void settings() {
  size(100,80);
}

void setup() {

  int year;
  Table track = loadTable("hurdat3.csv"); 
  Table this_track = new Table();
  String name = track.getString(0,2);
  String newhurr = track.getString(0,2);
  
  String year_str = track.getString(0,0);
  int isYear = track.getInt(0,0);
  println("hi");
  println(name);
  println(newhurr);
  println(year_str);
  println("Is year? ", isYear);


    println(year_str);
  println("Is year? ", isYear);
  
  if(isYear == 0){
    
    year = get_year(year_str);

    println(year);
    // create a new hurr
  
  } else {
    //add track
    this_track.addRow(track.getRow(0));
  }
  
}


void draw() {
  background(0);  // Ocean colour
  stroke(220);              // Boundary colour

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
