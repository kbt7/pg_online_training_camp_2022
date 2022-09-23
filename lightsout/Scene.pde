MainGame mainGame;

class Scene{
  Scene(){
    mainGame = new MainGame();
  }
  public void drawScene(){
    mainGame.drawPanel();
  }
  
  public void operate(){
    mainGame.selectPanel();
    if(mainGame.clearJudge()){
      println("clear");//ゲームクリア画面に移行//
    }
  }
}
