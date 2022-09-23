MainGame mainGame;

class Scene{
	
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
}
