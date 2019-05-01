//Control Panel

public class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  ListBox l;
  Toggle s;
  Toggle simage;
  boolean toggle = false;
  boolean toggleValue = false;
  CheckBox checkbox,checkbox2;
  int myColorBackground;
  IntList colorList;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();  
    parent = _parent;
    w = _w;
    _h = 1000;
    h =_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public Integer get_color(int i) {
    if (i >= 0){ return colorList.get(i); }
    return 0;
  }
  
  public void settings() {
    size(w, h);
  }

  public void setup() {
  surface.setLocation(10, 10);
  noStroke();
  cp5 = new ControlP5(this);
  setColorList();

  /*
  //===================== test =======================
  Group gtest = cp5.addGroup("gtest")
                .setPosition(160,240)
                .setSize(200,300)
                .setBarHeight(30)
                .setColorBackground(color(255, 0,0))
                .setColorActive(color(0))
                .setColorForeground(color(0,102,204))
                ;
  gtest.getCaptionLabel().set("Test");
  gtest.getCaptionLabel().setSize(20);


   for(int i = 0; i< 9;i++){
   int num = colorList.get(i);
   checkbox = cp5.addCheckBox("checkBox"+i)
               .setPosition(110,(-70+i*30))
               .setSize(100,20)
               .setSpacingColumn(60)
               .setItemsPerRow(2)
               .setColorLabel(num)
               .setColorBackground(color(0xffff8800))
               .setColorForeground(color(0,102,204))
               ;
    checkbox.setGroup(gtest);
    String sd = nfs(i,2).replaceAll("\\s","");
    checkbox.addItem("20"+sd, i);
  }
  
  */
  //===================== end test =======================




//===================== List of decades =======================
  List<Group> groups = new ArrayList<Group>();

  for( Integer i=0; i<12; i++){
    Integer year = (1900 + i*10);
    Integer year2 = (1910 + i*10);
    Group group = cp5.addGroup("g"+i.toString())
                .setPosition(10,150+i*50)
                .setSize(200,500)
                .setBarHeight(40)
                .setColorBackground(color(255, 100,0))
                .setColorActive(color(0))
                .setColorForeground(color(0,102,204))
                ;
    group.getCaptionLabel().set("Hurricance "+year.toString() + "-" + year2.toString() );
    group.getCaptionLabel().setSize(19);
    groups.add(group);
  }
  
  
  
   for(int i = 0; i< 9;i++){
     int num = colorList.get(i);
     checkbox = cp5.addCheckBox("checkBox"+i)
                 .setPosition(220,(-30+i*30))
                 .setSize(100,20)
                 .setSpacingColumn(60)
                 .setItemsPerRow(2)
                 .setColorLabel(num)
                 .setColorBackground(color(0xffff8800))
                 .setColorForeground(color(0,102,204))
                 ;
      checkbox.setGroup(groups.get(0));
      String sd = nfs(i,2).replaceAll("\\s","");
      checkbox.addItem("20"+sd, i);
    }
  
  
  
  
  
  
  

 /* 
  //=====================checkbox for 2001-2018=======================
   for(int i = 0; i<19;i++){
   int num = colorList.get(i);
   checkbox = cp5.addCheckBox("checkBox"+i)
               .setPosition(210,(-70+i*30))
               .setSize(100,20)
               .setSpacingColumn(60)
               .setItemsPerRow(2)
               .setColorLabel(num)
               .setColorBackground(color(0xffff8800))
               .setColorForeground(color(0,102,204))
               ;
    String sd = nfs(i,2).replaceAll("\\s","");
    checkbox.addItem("20"+sd, i);
    if(i>10){
    checkbox.setGroup(g2);
    }else{
    checkbox.setGroup(g2);
    }

             }

  //=====================checkbox for 1901-2000=======================
   for(int i = 0; i<99;i++){
   int num = colorList.get(0);
   checkbox2 = cp5.addCheckBox("checkBox2"+i)
               .setPosition(10,(i*30))
               .setSize(50,20)
               .setSpacingColumn(60)
               .setColorLabel(num)
               .setColorBackground(color(0xffff8800))
               .setColorForeground(color(0,102,204))
               ;

    String sd = nfs(i,2).replaceAll("\\s","");
    checkbox2.addItem("19"+sd, i);
    if(0<i<10){
        checkbox2.setGroup(g2);
    }else if(10<i<20){
          checkbox2.setGroup(g3);
    }else if(20<i<30){
          checkbox2.setGroup(g4);
    }else if(30<i<40){
          checkbox2.setGroup(g5);
    }else if(40<i<50){
          checkbox2.setGroup(g6);
    }else if(50<i<60){
          checkbox2.setGroup(g7);
    }else if(60<i<70){
          checkbox2.setGroup(g8);
    }else if(70<i<80){
          checkbox2.setGroup(g9);
    }else if(80<i<90){
          checkbox2.setGroup(g10);
    }else if(90<i<99){
          checkbox2.setGroup(g11);
    }
    
    
   if(i>25){
      checkbox2.setPosition(110,i*30-26*30);
    }else if(i>50){
      checkbox2.setPosition(210,i*30-26*30);
    }else if(i>75){
      checkbox2.setPosition(260,i*30-26*30);
    }
    
  }
*/

   // ==================== Switch button ======================
  cp5.begin();
  s = cp5.addToggle("toggleValue")
     .setPosition(10,30)
     .setSize(100,30)
     .setWidth(200)
     .setMode(ControlP5.SWITCH)
     ;
  s.getCaptionLabel().set("Show Me the Graph");
  s.getCaptionLabel().setSize(20);

  
  //====================== Toggle for NOAA graph====================
   

  simage = cp5.addToggle("toggle")
     .setPosition(250,30)
     .setSize(100,30)
     .setWidth(150)
     .setMode(ControlP5.SWITCH)
     ;
  simage.getCaptionLabel().set("NOAA graph");
  simage.getCaptionLabel().setSize(20);
  cp5.end();
  
  
  }

  void draw() {
    background(0);
  }
  
  //switch button value
    
  boolean getToggleValueImage(){
    return toggle;
  }
  boolean getToggleValue(){
    return toggleValue;
  }

  
 
  //event triggers when open
  void controlEvent(ControlEvent theEvent) {
  String temp;
  int year = 0;
  if(theEvent.isGroup()) {
     /* println("got an event from group "
            +theEvent.getGroup().getName()
            +", isOpen? "+theEvent.getGroup().isOpen()
            );
           */
           
    //println(checkbox.getArrayValue());
    
    temp = theEvent.getGroup().getName();
    char c_tens = (temp.charAt(temp.length() - 2));
    char c = (temp.charAt(temp.length() - 1));
    
    if (Character.isDigit(c_tens)){
      year += 10;
      println(1000);
    }
    
    year += Character.getNumericValue(c);
    

  if(theEvent.getGroup().getArrayValue()[0] == 1) {
        theEvent.getGroup().setArrayValue(0,0);
        add_year(year+2000);

      } else {
        remove_year(year + 2000);
        theEvent.getGroup().setArrayValue(0,1);
      }
    
    
  } else if (theEvent.isController()){
    println("got something from a controller "
            +theEvent.getController().getName()
            );
            
  }
  
  if (theEvent.isFrom(checkbox)) {
    

    myColorBackground = 170;
   /* 
    print("got an event from "+checkbox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(checkbox.getArrayValue());
    
    
     */ 
    for (int i=0;i<checkbox.getArrayValue().length;i++) {
      int n = (int)checkbox.getArrayValue()[i];
    
      if(n==1) {
        myColorBackground += checkbox.getItem(i).internalValue();
        remove_year(i+2018);

      } else if (n == 0) {
        
        add_year(2018);
      }
    }

  }

  else if(theEvent.isFrom(checkbox2)){
     for (int i=0;i<checkbox.getArrayValue().length;i++) {
      int n = (int)checkbox.getArrayValue()[i];
    
      if(n==1) {
        myColorBackground += checkbox.getItem(i).internalValue();
        remove_year(i+2018);

      } else if (n == 0) {
        
        add_year(2018);
      }
    }
  }

  }


  void setColorList(){
    colorList = new IntList();
    colorList.append(#b19cd9);  // pastel purple
    colorList.append(#bfbfbf); //Gray
    colorList.append(#ffffff); //White
    colorList.append(#cbbe88); //Inverted 
    colorList.append(#7eb6ff); // Parakeet light Blue
    
    colorList.append(#327932); // green
    colorList.append(#e62020); //Lust orange
    colorList.append(#849318);  //yellow green
    colorList.append(#653a71);  //purple
    colorList.append(#986c13);  //yellow brown
    
    colorList.append(#00ab7a);  //green cyan
    colorList.append(#884323);  //red brown
    colorList.append(#cccc00);  //darker yellow
    colorList.append(#ffcff1);  //pink
    colorList.append(#f64a8a);  // french rose
    
    colorList.append(#720b98);  //chinese purple
    colorList.append(#fb4d46);  //Tart orange
    colorList.append(#fd7657);  //light red
    colorList.append(#e9ffdb);  //Nyanza
  }
  
}
