class Map{
  private int w, h;
  private int[][] mp;
  private int[][] goal;
  private final int PANELSIZE = 100;
  private final int GOLESIZE = 100;
  private boolean isPressed;
  Map() {
    this(5, 5);
  }
  Map(int w, int h) {
    this.h = h;
    this.w = w;
    mp = new int[w][h];
    goal = new int[w][h];
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        mp[i][j] = 1;
        goal[i][j] = 1;
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
        rect(j * PANELSIZE + width / 4 - w/2.0*PANELSIZE,
             i * PANELSIZE + height /2 - h/2.0*PANELSIZE, 
             PANELSIZE, PANELSIZE);
      }
    }
  }
  
  public void drawGoalPanel() {
    for (int i = 0; i < h; i++) {
      for (int j = 0; j < w; j++) {
        fill(128 + 127 * goal[j][i]);
        rect(j * GOLESIZE + width / 4 * 3 - w/2.0*GOLESIZE,
             i * GOLESIZE + height /2 - h/2.0*GOLESIZE, 
             GOLESIZE, GOLESIZE);
      }
    }
  }
  
  public void selectPanel(){
    if (mousePressed && !isPressed) {
      int selectX = floor((mouseX + w/2.0 * PANELSIZE - width/4)/PANELSIZE);
      int selectY = floor((mouseY + h/2.0 * PANELSIZE - height/2)/PANELSIZE);
      if (turnPanel(selectX, selectY)) {
        turnPanel(selectX + 1, selectY);
        turnPanel(selectX - 1, selectY);
        turnPanel(selectX, selectY + 1);
        turnPanel(selectX, selectY - 1);
        isPressed = true;
      }
    } else if (!mousePressed && isPressed) {
      isPressed = false;
    }
  }
  
  public void selectGoal() {
    if (mousePressed && !isPressed) {
      int selectX = floor((mouseX + w/2.0 * GOLESIZE - width/4 * 3)/GOLESIZE);
      int selectY = floor((mouseY + h/2.0 * GOLESIZE - height/2)/GOLESIZE);
      trunGoal(selectX, selectY);
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
  
  private void trunGoal(int x, int y) {
    if (0 <= x && x < w && 0 <= y && y < h) {
      goal[x][y] ^= 1;
      mp[x][y] ^= 1;
    }
  }
}
