class MainGame{
  int[][] panel;   
  MainGame(){
    panel = new int[5][5];
  }
  public void drawPanel(){
    for(int i = 0 ; i < 5 ; i ++ ){
      for(int j = 0 ; j < 5 ; j ++ ){
        if(panel[i][j] == 0 ){
          fill(128);
        }
        else if(panel[i][j] == 1 ){
          fill(255);
        }
        rect(i*100,j*100,100,100);
      }
    }
  }
}
