class MainGame{
  int[][] panel;
  int h,w,panelSize = 100;
  boolean isPressed = false;

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
  /*public void selectPanel(){
    if (mousePressed&&isPressed == false){
      if(mouseX<w*panelSize&&mouseX>=0&&mouseY<h*panelSize&&mouseY>=0){
          panel[mouseX/panelSize][mouseY/panelSize] = 1;
      }
      isPressed = true;
    }
    else if (isPressed && mousePressed == false){
      isPressed = false;
    }
      
  }*/
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
