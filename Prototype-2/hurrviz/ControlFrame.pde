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
  List<Group> groups = new ArrayList<Group>();
  List<Button> buttons = new ArrayList<Button>();
  List<CheckBox> boxes = new ArrayList<CheckBox>();

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();  
    parent = _parent;
    w = _w;
    _h = 1000;
    h =_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public Integer get_color(int i) {
    i = i-1900;
    int j = i / 10;
    float k = i - j * 10;
    k = k / 13.0;
    
    //return lerpColor(colorList.get(j) , color(255),k);
    return colorList.get(j);
  }
  
  public void settings() {
    size(w, h);
  }

  public void setup() {
  surface.setLocation(10, 10);
  noStroke();
  cp5 = new ControlP5(this);
  setColorList();
  

//===================== List of decades =======================


  for( Integer i=0; i<12; i++){
    Integer year = (1900 + i*10);
    Integer year2 = (1909 + i*10);
    Integer name = (190 + i*1);
    Group group = cp5.addGroup(name.toString())
                .setPosition(10,200)
                .hide()
                .setColorBackground(color(71.37))
                .setColorActive(color(85.88))
                .setColorForeground(color(85.88))
                .setBarHeight(0);
    group.getCaptionLabel().set( "" );
    groups.add(group);
    
    int labelnum = colorList.get(i);
    String bname = nfs(i,2).replaceAll("\\s","");
    Button but = cp5.addButton("b"+bname)
                .setPosition(10,150+i*55)
                .setSize(200,40)
                .setColorBackground(color(71.37))
                .setColorActive(color(85.88))
                .setColorForeground(color(85.88))
                ;
    but.getCaptionLabel().set("Hurricance "+year.toString() + "-" + year2.toString() );
    but.getCaptionLabel().setSize(19);
    but.getCaptionLabel().setColor(labelnum);
    buttons.add(but);
  }
  
    Button clear = cp5.addButton("clear")
                .setPosition(200,height-100)
                .setSize(200,40)
                .setColorBackground(color(71.37))
                .setColorActive(color(85.88))
                .setColorForeground(color(85.88))
                ;
    clear.getCaptionLabel().set("Clear All ");
    clear.getCaptionLabel().setSize(19);
    clear.getCaptionLabel().setColor(color(#FFFFFF));


  
  
  //===================== List of years =======================

  
  for (Group g : groups){
    String name = g.getName();
    for(int i = 0; i< 10;i++){
      int num = colorList.get(i);
      int m = groups.indexOf(g);
      float lerpAmount = i/15.0;
      color fc = lerpColor(colorList.get(m), color(255),lerpAmount);
      
      String name2 = nfs(i,1).replaceAll("\\s","");
      checkbox = cp5.addCheckBox("c"+name+i)
                  .setPosition(220,(-30+i*40))
                  .setSize(65,30)
                  .setSpacingColumn(60)
                  .setItemsPerRow(2)
                  .setColorLabel(fc)
                  .setColorBackground(color(150))
                  .setColorForeground(color(200,10,10))
                  .setColorActive(color(fc));
      checkbox.setGroup(g);
      
      checkbox.addItem(name+name2, i);
      
      boxes.add(checkbox);
    }
  }

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
    
    temp = theEvent.getGroup().getName();
    temp = temp.substring(1,(temp.length()));
    

    //TODO: change this

    
    year = Integer.parseInt(temp); 
    //year +=  + Character.getNumericValue(c_tens) * 10;

  if(theEvent.getGroup().getArrayValue()[0] == 1) {
        theEvent.getGroup().setArrayValue(0,0);
        add_year(year);
        //println("add year", year);
        
      } else {
        remove_year(year);
        theEvent.getGroup().setArrayValue(0,1);
      }
    
    
  } else if (theEvent.isController()){
    
    if (theEvent.getController().getName() == "clear"){
      for (CheckBox c : boxes){
          c.deactivateAll();
          
      }
      return ;
    }
    
              
            
    char c = theEvent.getController().getName().charAt(theEvent.getController().getName().length() - 1);
    char c2 = theEvent.getController().getName().charAt(theEvent.getController().getName().length() - 2);
    Integer index = Character.getNumericValue(c) + Character.getNumericValue(c2) * 10;

    if(groups.get(index).isVisible()) {
      groups.get(index).hide();
      buttons.get(index).setColorBackground(color(128));
    }
    else {
      hideAll();
      groups.get(index).show();
      buttons.get(index).setColorBackground(color(85.88));

    }
    
  }
  
  if (theEvent.isFrom(checkbox)) {
    

    myColorBackground = 170;
   /* 
    print("got an event from "+checkbox.getName()+"\t\n");
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

  void hideAll(){
    for( Integer i=0; i<12; i++){
        groups.get(i).hide();
        buttons.get(i).setColorBackground(color(85.88));
    }
  }
  
  
  void setColorList(){
    colorList = new IntList();
    colorList.append(#FF0000); //red
    colorList.append(#FF7F00); //orange
    colorList.append(#FFFF00); //yellow
    colorList.append(#00FF00); //GREEN
    colorList.append(#0000FF); //BLUE

    colorList.append(#720b98);  //chinese purple
    colorList.append(#00ab7a);  //green cyan
    colorList.append(#ffcff1);  //pink
    colorList.append(#f64a8a);  // french rose
    colorList.append(#849318);  //yellow green
    colorList.append(#986c13);  //yellow brown
    
    
    colorList.append(#b19cd9);  // pastel purple
    colorList.append(#cbbe88); //Inverted 
    colorList.append(#7eb6ff); // Parakeet light Blue
    
    colorList.append(#327932); // green
    colorList.append(#653a71);  //purple
    colorList.append(#884323);  //red brown
    colorList.append(#cccc00);  //darker yellow

    colorList.append(#fb4d46);  //Tart orange
    colorList.append(#fd7657);  //light red
    colorList.append(#e9ffdb);  //Nyanza
  }
  
}
