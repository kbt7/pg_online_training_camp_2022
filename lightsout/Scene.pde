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
  private Stage[] stage;
  
  private int pickStage;
  private boolean isPressed;
  
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
    
    pickStage = 0;
    
    load = new TextLoad();
    stage = new Stage[load.fileNames.length];
    for(int i = 0; i < load.fileNames.length; i++){
      stage[i] = new Stage(i * 120, 400, load.fileNames[i]);
      if(i == pickStage){
        stage[i].select();
      }
    }
    
    gameMode = GameMode.TITLE;
    isPressed = true;
  }
  
  public void drawScene(){
    mainGame.drawPanel();
    //mainGame.goalPanel();
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
    for(int i = 0; i < load.fileNames.length; i++){
      stage[i].draw();
    }
  }
  
  private void resultDraw(){
    
    textAlign(TOP, LEFT);
    fill(0);
    text("Game END", 50, 50);
    textAlign(TOP,RIGHT);
    fill(0);
    text("手数"+mainGame.getCount(), 200, 50);

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
            if (load.fileNames[pickStage].equals("random")) {
              mainGame = new MainGame(5, 5);
              mainGame.randomMap(10);
            } else {
              mainGame = new MainGame(load.mapLoad(pickStage));//本来はゲームプレイ用のシーンでインスタンス生成
            }
            gameMode = gamePlay.getGameMode();
          }
          for(int i = 0; i < load.fileNames.length; i++) {
            if(stage[i].onMouse()){
              stage[pickStage].unselect();
              pickStage = i;
              stage[i].select();
            }
          }
        }
        break;
      case PLAY:
        mainGame.selectPanel();
        if(mainGame.stageClear()){
          isPressed = true;
          gameMode = GameMode.RESULT;//ゲームクリア画面に移行//
        }
        break;
      case RESULT:
        if(mousePressed && !isPressed){
          if(title.onMouse()){
            gameMode = title.getGameMode();
          }
          else if(gameEnd.onMouse()){
            gameMode = gameEnd.getGameMode();
          }
        }
        if (!mousePressed) isPressed = false;
        break;
      default:
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
        text("end. I want to close game.", width / 2, height / 2);
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

private class Stage{
  final int PanelWidth = 100;
  final int PanelHeight = 100;
  final color DefaultColor = color(100, 100, 100);
  final color EdgeColor = color(255, 100, 100);
  final int HighAlpha = 255;
  final int LowAlpha = 150;
  final color textColor = color(100, 0, 0);
  final int textSize = 20;
  
  int x;
  int y;
  String str;
  color panelColor;
  boolean select;
  
  Stage(){}
  Stage(int x, int y){
    this.x = x;
    this.y = y;
    this.panelColor = DefaultColor;
    this.select = false;
  }
  
  Stage(int x, int y, String str){
    this(x, y);
    this.str = str;
  }
  
  Stage(int x, int y, String str, color c){
    this(x, y, str);
    this.panelColor = c;
  }
  
  public void select(){
    this.select = true;
  }
  
  public void unselect(){
    this.select = false;
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
    
    strokeWeight(4);
    stroke(EdgeColor);
    fill(0, 0, 0, 0);
    if(select){
      rect(x - 2, y - 2, PanelWidth + 2, PanelHeight + 2);
    }
    strokeWeight(1);
    stroke(0);
    
    fill(textColor);
    textAlign(CENTER);
    textSize(textSize);
    text(str, x + PanelWidth / 2, y + PanelHeight / 2);
  }
}
