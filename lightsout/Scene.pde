MainGame mainGame;
TextLoad load;

private enum GameMode{
  TITLE,
  PLAY,
  SELECT,
  RESULT,
  END
};

class Scene{
  private GameMode gameMode;
  
  private Select title, gamePlay, select, result, gameEnd;
  
  Audio se = new Audio("testSE.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
  Audio bgm = new Audio("testBGM.mp3");
  
  Scene(){
    title = new Select(0, 100, "title");
    gamePlay = new Select(0, 200, "game start");
    select = new Select(0, 250, "map select");
    result = new Select(0, 300, "result");
    gameEnd = new Select(0, 500, "finish");
    
    title.setGameMode(GameMode.TITLE);
    gamePlay.setGameMode(GameMode.PLAY);
    select.setGameMode(GameMode.SELECT);
    result.setGameMode(GameMode.RESULT);
    gameEnd.setGameMode(GameMode.END);
    
    gameMode = GameMode.TITLE;
  }
  
  public void drawScene(){
    mainGame.drawPanel();
  }
  
  private void titleDraw(){
    textAlign(TOP, LEFT);
    fill(0);
    text("Title GAMEN", 50, 50);
    select.draw();
    gameEnd.draw();
  }
  
  private void selectDraw(){
    textAlign(TOP, LEFT);
    fill(0);
    text("map selecting", 50, 50);
    gamePlay.draw();
  }
  
  private void resultDraw(){
    textAlign(TOP, LEFT);
    fill(0);
    text("Game END", 50, 50);
    title.draw();
    gameEnd.draw();
  }
  
  public void operate(){
    switch(gameMode){
      case TITLE:
        if(mousePressed){
          if(select.onMouse()){
            gameMode = select.getGameMode();
          }
          else if(gameEnd.onMouse()){
            gameMode = gameEnd.getGameMode();
          }
        }
        break;
      case SELECT:
        if(mousePressed){
          if(gamePlay.onMouse()){
            load = new TextLoad();
            mainGame = new MainGame(load.mapLoad(0));//本来はゲームプレイ用のシーンでインスタンス生成
            gameMode = gamePlay.getGameMode();
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
          else if(gameEnd.onMouse()){
            gameMode = gameEnd.getGameMode();
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
      case SELECT:
        selectDraw();
        break;
      case PLAY:
        operate();
        drawScene();
        break;
      case RESULT:
        resultDraw();
        break;
      case END:
        text("end I want to close game", width / 2, height / 2);
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
