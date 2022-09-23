class MainGame{
  int[][] panel;
  int h,w,panelSize = 100;
  boolean isPressed = false;
  
  int[][] samplepanel  = {{0,0,0,0,0},{0,1,1,0,0},{0,0,1,0,0},{0,0,1,1,0},{0,0,0,0,0}};

  MainGame(){
    h = 5;
    w = 5;
    panel = new int[w][h];
  }
  
  public void drawPanel(){
    for(int i = 0 ; i < w ; i ++ ){
      for(int j = 0 ; j < h ; j ++ ){
        if(panel[i][j] == 0 ){
          fill(128);
        }
        else if(panel[i][j] == 1 ){
          fill(255);
        }
        rect(i*panelSize,j*panelSize,panelSize,panelSize);
      }
    }
  }
  
  public boolean stageClear(){
    for(int i = 0 ; i < w ; i ++ ){
      for(int j = 0 ; j < h ; j ++ ){
        if(panel[i][j] == 0){
          return false;                 //未達成
          }
        }
      }
      return true;                        //達成
    }
  
  public boolean stageClear(int[][] stage){ // int[][] stageはテキストファイルなどに用意する
    for(int i = 0 ; i < w ; i ++ ){
      for(int j = 0 ; j < h ; j ++ ){
        if(panel[i][j] != stage[i][j]){
          return false;                 //未達成
        }
      }
    }
    return true;                        //達成
  }
  
  public void selectPanel(){
    if (mousePressed && !isPressed){
      int selectX = mouseX/panelSize;
      int selectY = mouseY/panelSize;
      turnPanel(selectX, selectY);
      turnPanel(selectX+1, selectY);
      turnPanel(selectX-1, selectY);
      turnPanel(selectX, selectY+1);
      turnPanel(selectX, selectY-1);
      isPressed = true;
    } else if (isPressed && !mousePressed){
      isPressed = false;
    }
  }
  
  public void turnPanel(int x, int y){
     if(x < w && x >= 0 && y < h && y >= 0){
      panel[x][y] ^= 1;
     }
  }
}
