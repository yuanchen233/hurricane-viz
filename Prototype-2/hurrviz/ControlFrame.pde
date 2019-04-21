//Left Applet

public class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  ListBox l;
  Toggle s, s2;
  boolean toggleValue = false;
  CheckBox checkbox;
  int myColorBackground;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
  surface.setLocation(10, 10);
  noStroke();
  cp5 = new ControlP5(this);
  
  // ==================List======================
  Group g = cp5.addGroup("g1")
                .setPosition(10,210)
                .setSize(300,500)
                .setBarHeight(40)
                .setColorBackground(color(255, 100,0))
                .setColorActive(color(0))
                .setColorForeground(color(0,102,204))
                ;
  g.getCaptionLabel().set("YEARLY HURRICANE");
  g.getCaptionLabel().setSize(30);

  //================check box ============================
  checkbox = cp5.addCheckBox("checkBox")
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
    checkbox.addItem("200"+i, i);
  }
    for (int i=10;i<19;i++) {
    checkbox.addItem("20"+i, i);
  }
   
  checkbox.setGroup(g);


   
   
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
  if(theEvent.isGroup()) {
    println("got an event from group "
            +theEvent.getGroup().getName()
            +", isOpen? "+theEvent.getGroup().isOpen()
            );
            
  } else if (theEvent.isController()){
    println("got something from a controller "
            +theEvent.getController().getName()
            );
  }
  
  if (theEvent.isFrom(checkbox)) {
    myColorBackground = 170;
    print("got an event from "+checkbox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(checkbox.getArrayValue());
    for (int i=0;i<checkbox.getArrayValue().length;i++) {
      int n = (int)checkbox.getArrayValue()[i];
      print(n);
      if(n==1) {
        myColorBackground += checkbox.getItem(i).internalValue();
        add_year(i+2001);
      } else if (n == 0) {
        remove_year(i+2001);
      }
    }
    println();    
  }

 }
 
void checkBox(float[] a) {
  println(a);
}

}
