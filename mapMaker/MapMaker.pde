
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
  size(800, 600);
  px = 0;
  py = 0;
  println("キーボードから数値を入力せよ");
}

void draw() {
  if (!yetInit) {
    if (keyPressed && !isPressed) {
      if (px == 0) {
         px = key - '0';
         if (px < 0 || 10 <= px) px = 0;
         if (px != 0) println("width = " + px);
      } else if (py == 0){
        py = key - '0';
        if (py < 0 || 10 <= py) py = 0;
        if (py != 0) println("height = " + py);
      } 
      isPressed = true;
    }else if (!keyPressed && isPressed){
      isPressed = false;
    }
    if (px != 0 && py != 0) {
      init(px, py);
    }
  } else {
    map.selectPanel();
    map.drawPanel();
    if (keyPressed && key == ENTER && !isPressed) {
      mapWrite.save(map.getMap(), map.getWidth(), map.getHeight());
      isPressed = true;
    } else if (!keyPressed && isPressed) {
      isPressed = false;
    }
  }
}
