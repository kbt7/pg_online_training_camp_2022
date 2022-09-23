class MainGame{
  int[][] panel;
  int h,w,panelSize = 100;
  
  int[][] samplepanel  = {{0,0,0,0,0},{0,1,1,0,0},{0,0,1,0,0},{0,0,1,1,0},{0,0,0,0,0}};
  
  MainGame(){
    h = 5;
    w = 5;
    panel = new int[w][h];
    samplepanel = new int [w][h];
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
  public void selectPanel(){
    if (mousePressed){
      if(mouseX<500&&mouseX>=0&&mouseY<500&&mouseY>=0){
          panel[mouseX/100][mouseY/100] = 1;
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
}
