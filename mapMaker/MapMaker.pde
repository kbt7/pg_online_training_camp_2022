
Map map;
MapWrite mapWrite;

boolean yetInit = false;
boolean isPressed;
int px, py;

void init(int x, int y) {
  map = new Map(x, y);
  mapWrite = new MapWrite();
  yetInit = true;
  isPressed = true;
  println("Enetrで出力");
}

void setup(){
  size(1200, 600);
  px = 0;
  py = 0;
  PFont font = createFont("MS Gothic",50);
  textFont (font);
  textAlign(CENTER);
  text("キーボードから数値を入力せよ", width/2, height/2);
}

void draw() {
  if (!yetInit) {
    if (keyPressed && !isPressed) {
      if (px == 0) {
         px = key - '0';
         if (px < 0 || 10 <= px) px = 0;
         if (px != 0) text("width = " + px, width/2, height/2 + 50);
      } else if (py == 0){
        py = key - '0';
        if (py < 0 || 10 <= py) py = 0;
        if (py != 0) text("height = " + py, width/2, height/2 + 100);
      } 
      isPressed = true;
    }else if (!keyPressed && isPressed){
      isPressed = false;
    }
    if (px != 0 && py != 0) {
      init(px, py);
    }
  } else {
    background(200);
    map.selectPanel();
    map.selectGoal();
    map.drawPanel();
    map.drawGoalPanel();
    if (keyPressed && key == ENTER && !isPressed) {
      mapWrite.save(map.getMap(), map.getWidth(), map.getHeight());
      isPressed = true;
    } else if (!keyPressed && isPressed) {
      isPressed = false;
    }
  }
}
