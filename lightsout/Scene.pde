MainGame mainGame;
TextLoad load;

private enum GameMode{
  TITLE,
  PLAY,
  RESULT
};

class Scene{
  private GameMode gameMode;
  
  private Select title, gamePlay, result;
  
  Audio se = new Audio("testSE.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
  Audio bgm = new Audio("testBGM.mp3");
  
  Scene(){
    load = new TextLoad();
    mainGame = new MainGame(load.mapLoad(0));//本来はゲームプレイ用のシーンでインスタンス生成
    
    title = new Select(0, 100, "title");
    gamePlay = new Select(0, 200, "game start");
    result = new Select(0, 300, "result");
    
    title.setGameMode(GameMode.TITLE);
    gamePlay.setGameMode(GameMode.PLAY);
    result.setGameMode(GameMode.RESULT);
    
    gameMode = GameMode.TITLE;
  }
  
  public void drawScene(){
    mainGame.drawPanel();
  }
  
  private void titleDraw(){
    textAlign(TOP, LEFT);
    fill(0);
    text("Title GAMEN", 50, 50);
    title.draw();
    gamePlay.draw();
    result.draw();
  }
  
  private void resultDraw(){
    textAlign(TOP, LEFT);
    fill(0);
    text("Game END", 50, 50);
    title.draw();
    gamePlay.draw();
    result.draw();
  }
  
  public void operate(){
    switch(gameMode){
      case TITLE:
        if(mousePressed){
          if(title.onMouse()){
            gameMode = title.getGameMode();
          }
          else if(gamePlay.onMouse()){
            gameMode = gamePlay.getGameMode();
          }
          else if(result.onMouse()){
            gameMode = result.getGameMode();
          }
        }
        break;
      case PLAY:
        mainGame.selectPanel();
        if(mainGame.stageClear()){
          gameMode = GameMode.RESULT;//ゲームクリア画面に移行//
        }
        break;
      case RESULT:
        if(mousePressed){
          if(title.onMouse()){
            gameMode = title.getGameMode();
          }
          else if(gamePlay.onMouse()){
            gameMode = gamePlay.getGameMode();
          }
          else if(result.onMouse()){
            gameMode = result.getGameMode();
          }
        }
        break;
    }
  }
  
  public void draw(){
    switch(gameMode){
      case TITLE:
        titleDraw();
        break;
      case PLAY:
        operate();
        drawScene();
        break;
      case RESULT:
        resultDraw();
        break;
    }
  }
}

private class Select{
  final int PanelWidth = 500;
  final int PanelHeight = 50;
  final color DefaultColor = color(100, 255, 100);
  final int HighAlpha = 255;
  final int LowAlpha = 150;
  final color textColor = color(255, 0, 0);
  final int textSize = 30;
  
  int x, y;
  String str;
  color panelColor;
  GameMode gameMode;
  
  Select(){}
  Select(int x, int y){
    this.x = x;
    this.y = y;
    this.str = "test text";
    this.panelColor = DefaultColor;
  }
  
  Select(int x, int y, String str){
    this(x, y);
    this.str = str;
  }
  
  Select(int x, int y, String str, color c){
    this(x, y, str);
    this.panelColor = c;
  }
  
  public void setGameMode(GameMode gameMode){
    this.gameMode = gameMode;
  }
  
  public GameMode getGameMode(){
    return gameMode;
  }
  
  public boolean onMouse(){
    if(x <= mouseX && mouseX <= x + PanelWidth &&
        y <= mouseY && mouseY <= y + PanelHeight){
      return true;      
    }
    return false;
  }
  
  public void draw(){
    if(this.onMouse()){
      fill(panelColor, HighAlpha);
    }
    else{
      fill(panelColor, LowAlpha);
    }
    rect(x, y, PanelWidth, PanelHeight);
    
    fill(textColor);
    textAlign(CENTER);
    textSize(textSize);
    text(str, x + PanelWidth / 2, y + PanelHeight / 2);
  }
}
