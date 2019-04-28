//Left Applet

public class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  ListBox l;
  Toggle s, s2;
  boolean toggleValue = false;
  CheckBox checkbox,checkbox2;
  int myColorBackground;
  IntList colorList;
  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public Integer get_color(int i) {
    if (i >= 0){
    return colorList.get(i);}
    
    return 0;
  }
  
  public void settings() {
    size(w, h);
  }

  public void setup() {
  surface.setLocation(10, 10);
  noStroke();
  cp5 = new ControlP5(this);
  
  // ==================List for 2001-2018======================
  Group g = cp5.addGroup("g1")
                .setPosition(10,210)
                .setSize(300,500)
                .setBarHeight(40)
                .setColorBackground(color(255, 100,0))
                .setColorActive(color(0))
                .setColorForeground(color(0,102,204))
                ;
  g.getCaptionLabel().set("Hurricance 2001-2018");
  g.getCaptionLabel().setSize(30);

  // ==================List for 2001-2008======================
  Group g2 = cp5.addGroup("g2")
                .setPosition(10,260)
                .setSize(300,500)
                .setBarHeight(40)
                .setColorBackground(color(255, 100,0))
                .setColorActive(color(0))
                .setColorForeground(color(0,102,204))
                ;
  g.getCaptionLabel().set("Hurricance 1900-2000");
  g.getCaptionLabel().setSize(30);
  //================check box ============================
 /* checkbox = cp5.addCheckBox("checkBox")
                .setPosition(0, 10)
                .setSize(80, 50)
                .setItemsPerRow(3)
                .setSpacingColumn(30)
                .setSpacingRow(5)
                .setItemHeight(40)
                .setColorBackground(color(0xffff8800))
                .setColorForeground(color(0,102,204))
                ;
  for (int i=1;i<10;i++) {
    
    checkbox.addItem("200"+i,i);
  }


  
    for (int i=10;i<19;i++) {
    checkbox.addItem("20"+i, i);
  }
  checkbox.addItem("SHOW ALL HURRICANE",20); 
  */
  
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
  
  //println(colorList);  
  //=====================checkbox for 2001-2018=======================
   for(int i = 1; i<19;i++){
   int num = colorList.get(i-1);
   checkbox = cp5.addCheckBox("checkBox"+i)
               .setPosition(0,i*30)
               .setSize(100,20)
               .setSpacingColumn(60)
               .setItemsPerRow(2)
               .setColorLabel(num)
               .setColorBackground(color(0xffff8800))
               .setColorForeground(color(0,102,204))
               ;
    checkbox.setGroup(g);
               if(i<10){
               checkbox.addItem("200"+i,i);
               }else{
               checkbox.setPosition(0,i*30);
               checkbox.addItem("20"+i,i);
               }
             }
  

  //=====================checkbox for 1900-2000=======================
   
   for(int i = 1; i<19;i++){
   int num = colorList.get(i-1);
   checkbox2 = cp5.addCheckBox("checkBox2"+i)
               .setPosition(0,i*30-30)
               .setSize(100,20)
               .setSpacingColumn(60)
               .setItemsPerRow(2)
               .setColorLabel(num)
               .setColorBackground(color(0xffff8800))
               .setColorForeground(color(0,102,204))
               ;
    checkbox2.setGroup(g2);
               if(i<10){
               checkbox2.addItem("190"+i,i);
               }else{
               checkbox2.setPosition(0,i*30);
               checkbox2.addItem("19"+i,i);
               }
             }
   
     s2 = cp5.addToggle("toggle")
     .setPosition(10,100)
     .setSize(100,30)
     .setWidth(width)
     .setMode(ControlP5.SWITCH)
     ;
  s2.getCaptionLabel().set("TOP TEN HURRICANE");
  s2.getCaptionLabel().setSize(20);
// ==================List======================
/* 

  l = cp5.addListBox("myList")
         .setPosition(0, 0)
         .setSize(300, 500)
         .setBarHeight(45)
         .setColorBackground(color(0xffff8800))
         .setColorActive(color(0))
         .setColorForeground(color(0,102,204))
         ;

  l.getCaptionLabel().toUpperCase(true);
  l.getCaptionLabel().set("Year");
  l.getCaptionLabel().setSize(20);

  l.setItemHeight(40);
  l.setWidth(width);
  

  for (int i=1;i<10;i++) {
    l.addItem("200"+i, i);
    l.getItem("200"+i).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
  }
    for (int i=10;i<19;i++) {
    l.addItem("20"+i, i);
    l.getItem("20"+i).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
  }
  l.setGroup(g);
  */
   // ==================Switch button======================
  cp5.begin();
  s = cp5.addToggle("toggleValue")
     .setPosition(10,30)
     .setSize(100,30)
     .setWidth(width)
     .setMode(ControlP5.SWITCH)
     ;
  s.getCaptionLabel().set("Show Me the Graph");
  s.getCaptionLabel().setSize(20);
  cp5.end();
  
  
  
  
  }

  void draw() {
    background(0);
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

  }else if(theEvent.isFrom(checkbox2)){
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
 
void checkBox(float[] a) {
  println(a);
}

void checkBox2(float[] a) {
  println(a);
}

}
