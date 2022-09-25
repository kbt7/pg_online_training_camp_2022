class Map{
  private int w, h;
  private int[][] mp;
  private final int panelSize = 100;
  private boolean isPressed;
  Map() {
    this(5, 5);
  }
  Map(int w, int h) {
    this.h = h;
    this.w = w;
    mp = new int[w][h];
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        mp[i][j] = 1;
      }
    }
    isPressed = true;
  }
  
  public int getWidth(){ return w; }
  public int getHeight(){ return h; }
  public int[][] getMap(){ return mp; }
  
  public void drawPanel() {
    for (int i = 0; i < h; i++) {
      for (int j = 0; j < w; j++) {
        fill(128 + 127 * mp[j][i]);
        rect(j * panelSize + width /2 - w/2.0*panelSize,
             i * panelSize + height /2 - h/2.0*panelSize, panelSize, panelSize);
      }
    }
  }
  
  public void selectPanel(){
    if (mousePressed && !isPressed) {
      int selectX = floor((mouseX + w/2.0 * panelSize - width/2)/panelSize);
      int selectY = floor((mouseY + h/2.0 * panelSize - height/2)/panelSize);
      if (turnPanel(selectX, selectY)) {
        turnPanel(selectX + 1, selectY);
        turnPanel(selectX - 1, selectY);
        turnPanel(selectX, selectY + 1);
        turnPanel(selectX, selectY - 1);
      }
      isPressed = true;
    } else if (!mousePressed && isPressed) {
      isPressed = false;
    }
  }
  
  private boolean turnPanel(int x,int y) {
    if (0 <= x && x < w && 0 <= y && y < h) {
      mp[x][y] ^= 1;
      return true;
    }
    return false;
  }
}
