MainGame mainGame;

class Scene{
<<<<<<< HEAD
  Select select;
  Scene(){
    mainGame = new MainGame();
    select = new Select(0, 0);
  }
  
  public void drawScene(){
    mainGame.drawPanel();
    select.draw();
  }
  
  public void operate(){
    mainGame.selectPanel();
    if(mainGame.stageClear()){
      println("clear");//ゲームクリア画面に移行//
    }
  }
}

protected class Select{
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
    rect(x, y, x + PanelWidth, y + PanelHeight);
    
    fill(0);
    textAlign(CENTER);
    textSize(textSize);
    text(str, x, y);
  }
=======
	
	Audio se = new Audio("testSE.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
	Audio bgm = new Audio("testBGM.mp3");
	
	Scene() {
		mainGame = new MainGame();
	}
	public void drawScene() {
		mainGame.drawPanel();
	}
	
	public void operate() {
		
	}
>>>>>>> okayu
}
