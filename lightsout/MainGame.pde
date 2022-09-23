class MainGame{
  int[][] panel;   
  MainGame(){
    panel = new int[5][5];
  }
  public void drawPanel(){
    for(int i = 0 ; i < 5 ; i ++ ){
      for(int j = 0 ; j < 5 ; j ++ ){
        rect(i*100,j*100,(i+1)*100,(j+1)*100);
      }
    }
  }
}
