MainGame mainGame;
TextLoad load;

private enum GameMode{
	TITLE,
	PLAY,
	SELECT,
	RESULT,
	END
};

public class Scene{
	private GameMode gameMode;
	
	private Select title, gamePlay, select, result, gameEnd, nextPage, previousPage;
	private Stage[] stage;
	private int stageLimit = 4; //ステージセレクトで１画面に表示する最大数
	private int page = 1; //ステージセレクトで表示する現在のページ
	private int t1; //ゲーム終了時のメッセージ表示用millis()
	
	private int pickStage;
	//private boolean isPressed;
	
	// Audio se = new Audio("testSE.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
	Audio titleBgm = new Audio("Audio/BGM/BGM_Title.mp3");
	Audio mainBgm = new Audio("Audio/BGM/BGM_Main.mp3");
	
	Scene() {
		title = new Select(0, 100, "↩");
		gamePlay = new Select(0, 200, "GAME START");
		select = new Select(0, 250, "STAGE SELECT");
		result = new Select(0, 300, "RESULT");
		gameEnd = new Select(0, 500, "FINISH");
		nextPage = new Select(700,500, "→");  //ステージセレクト右
		previousPage = new Select(50,500,"←");  //ステージセレクト左
		nextPage.setPanelSize(50,50);
		previousPage.setPanelSize(50,50);
		title.setPanelSize(50,50);
		
		title.setGameMode(GameMode.TITLE);
		gamePlay.setGameMode(GameMode.PLAY);
		select.setGameMode(GameMode.SELECT);
		result.setGameMode(GameMode.RESULT);
		gameEnd.setGameMode(GameMode.END);
		
		pickStage = 0;
		
		titleBgm.setVolume( -20);
		mainBgm.setVolume( -20);
		
		load = new TextLoad();
		stage = new Stage[load.fileNames.length];
		int stagecount = 0;
		for (int i = 0; i < load.fileNames.length; i++) {
			stage[i] = new Stage(stagecount * 120 + 170, 400, load.fileNames[i]);
			stagecount++;
			if (stagecount > 3) { //4ステージごとに位置リセット
				stagecount = 0;
			}
			if (i == pickStage) {
				stage[i].select();
			}
		}
		
		gameMode = GameMode.TITLE;
	}
	
	public void drawScene() {
		title.draw();
		mainGame.drawPanel();
		//mainGame.goalPanel();
		if (!mainBgm.isPlaying()) {
		  mainBgm.rewind();
			mainBgm.play();
			titleBgm.pause();
		}
	}
	
	private void titleDraw() {
		textAlign(TOP, LEFT);
		fill(0);
		t1 = millis();
		text("LIGHTS OUT", 50, 50);
		select.draw();
		gameEnd.draw();
		if (!titleBgm.isPlaying()) {
		  titleBgm.rewind();
			titleBgm.play();
			mainBgm.pause();
		}
	}
	
	private void selectDraw() {
		textAlign(TOP, LEFT);
		fill(0);
		text("STAGE SELECT", 50, 50);
		gamePlay.draw();
		title.draw();
		// for (int i = 0; i < load.fileNames.length; i++) {
		// 	stage[i].draw();
		// }
		
		for (int i = 0;i < 4;i++) {
			int drawStage = i + (page - 1) * 4;
			if (drawStage < load.fileNames.length) {
				stage[drawStage].draw();
			}
		}
		
		double pageLimit = Math.ceil((double)load.fileNames.length / stageLimit);
		text(String.valueOf(this.page) + "/" + String.valueOf((int)pageLimit),width / 2,550); //現在のページ表示
		//println(Math.ceil((double)load.fileNames.length / stageLimit));
		if (page < pageLimit) {
			nextPage.setState(true);
			nextPage.draw();
		} else{
			nextPage.setState(false);  //透明なだけで触れていたため無効にする
		}
		if (page > 1) {
			previousPage.setState(true);
			previousPage.draw();
		} else{
			previousPage.setState(false);
		}
	}
	
	private void resultDraw() {
		t1 = millis();
		textAlign(TOP, LEFT);
		fill(0);
		text("Game Clear!　手数　"+mainGame.getCount(), 50, 50);
		title.draw();
		gameEnd.draw();
	}
	
	public void operate() {
		switch(gameMode) {
			case TITLE:
				if (select.onMouse()) {
					gameMode = select.getGameMode();
				}
				else if (gameEnd.onMouse()) {
					gameMode = gameEnd.getGameMode();
				}
				break;
			case SELECT:
				if (gamePlay.onMouse()) {
					if (load.fileNames[pickStage].equals("random")) {
						mainGame = new MainGame(5, 5);
						mainGame.randomMap(10);
					} else {
						mainGame = new MainGame(load.mapLoad(pickStage));//本来はゲームプレイ用のシーンでインスタンス生成
					}
					gameMode = gamePlay.getGameMode();
				}
				if (title.onMouse()) {
					gameMode = title.getGameMode();
				}
				for (int i = (page - 1) * 4; i < (page - 1) * 4 + 4; i++) {
					if (i < load.fileNames.length) {
						if (stage[i].onMouse()) {
							stage[pickStage].unselect();
							pickStage = i;
							stage[i].select();
						}
					}
				}
				if (nextPage.onMouse()) {
					if (nextPage.getState()) {
						this.page++;
						//println(this.page);
					}
				}
				if (previousPage.onMouse()) {
					if (previousPage.getState()) {
						this.page--;
						//println(this.page);
					}
				}
				break;
			case PLAY:
				mainGame.selectPanel();
				if (mainGame.stageClear()) {
					gameMode = GameMode.RESULT;//ゲームクリア画面に移行//
				}
				if (title.onMouse()) {
					gameMode = title.getGameMode();
				}
				break;
			case RESULT:
				if (title.onMouse()) {
					gameMode = title.getGameMode();
				}
				else if (gameEnd.onMouse()) {
					gameMode = gameEnd.getGameMode();
				}
				break;
			default:
			break;
		}
	}
	
	// public void operate() {
	// 	switch(gameMode) {
	// 		case TITLE:
	// 			if (mousePressed) {
	// 				if (select.onMouse()) {
	// 					gameMode = select.getGameMode();
	// 				}
	// 				else if (gameEnd.onMouse()) {
	// 					gameMode = gameEnd.getGameMode();
	// 				}
	// 			}
	// 			break;
	// 		case SELECT:
	// 			if (mousePressed) {
	// 				if (gamePlay.onMouse()) {
	// 					if (load.fileNames[pickStage].equals("random")) {
	// 						mainGame = new MainGame(5, 5);
	// 						mainGame.randomMap(10);
	// 					} else {
	// 						mainGame = new MainGame(load.mapLoad(pickStage));//本来はゲームプレイ用のシーンでインスタンス生成
	// 					}
	// 					gameMode = gamePlay.getGameMode();
	// 				}
	// 				for (int i = 0; i < load.fileNames.length; i++) {
	// 					if (stage[i].onMouse()) {
	// 						stage[pickStage].unselect();
	// 						pickStage = i;
	// 						stage[i].select();
	// 					}
	// 				}
	// 				if (nextPage.onMouse()) {
	// 					this.page++;
	// 					println(this.page);
	// 				}
	// 				if (previousPage.onMouse()) {
	// 					this.page--;
	// 					println(this.page);
	// 				}
	// 			}
	// 			break;
	// 		case PLAY:
	// 			mainGame.selectPanel();
	// 			if (mainGame.stageClear()) {
	// 				isPressed = true;
	// 				gameMode = GameMode.RESULT;//ゲームクリア画面に移行//
	// 			}
	// 			break;
	// 		case RESULT:
	// 			if (mousePressed && !isPressed) {
	// 				if (title.onMouse()) {
	// 					gameMode = title.getGameMode();
	// 				}
	// 				else if (gameEnd.onMouse()) {
	// 					gameMode = gameEnd.getGameMode();
	// 				}
	// 			}
	// 			if (!mousePressed) isPressed = false;
	// 			break;
	// 		default:
	// 		break;
	// 	}
	// }
	
	public void draw() {
		switch(gameMode) {
			case TITLE:
				titleDraw();
				break;
			case SELECT:
				selectDraw();
				break;
			case PLAY:
				//operate();
				drawScene();
				break;
			case RESULT:
				resultDraw();
				break;
			case END:
				text("See you next time!", width / 2, height / 2);
				if (millis() - t1 > 1000) {
					exit();
				}
				break;
		}
	}
}

private class Select{
	protected int PanelWidth = 500;
	protected int PanelHeight = 50;
	protected color DefaultColor = color(100, 255, 100);
	final int HighAlpha = 255;
	final int LowAlpha = 150;
	protected color textColor = color(255, 0, 0);
	protected int textSize = 30;
	private boolean state; //クリックされる項目が有効か無効か設定できる
	
	int x, y;
	String str;
	color panelColor;
	GameMode gameMode;
	
	//constructor
	Select() {}
	Select(int x, int y) {
		this.x = x;
		this.y = y;
		this.str = "test text";
		this.panelColor = DefaultColor;
		this.state = true;
	}
	
	Select(int x, int y, String str) {
		this(x, y);
		this.str = str;
	}
	
	Select(int x, int y, String str, color c) {
		this(x, y, str);
		this.panelColor = c;
	}
	
	//setter
	public void setGameMode(GameMode gameMode) {
		this.gameMode = gameMode;
	}
	public void setPanelSize(int height,int width) {
		this.PanelWidth = width;
		this.PanelHeight = height;
	}
	public void setPanelColor(color c) {
		this.DefaultColor = c;
	}
	public void setTextColor(color c) {
		this.textColor = c;
	}
	public void setState(boolean state) {
		this.state = state;
	}
	
	//getter
	public GameMode getGameMode() {
		return gameMode;
	}
	public boolean getState() {
		return this.state;
	}
	
	public boolean onMouse() {
		if (x <= mouseX && mouseX <= x + PanelWidth && 
			y <= mouseY && mouseY <= y + PanelHeight) {
			return true;
		}
		return false;
	}
	
	public void draw() {
		if (this.state) {
			if (this.onMouse()) {
				fill(panelColor, HighAlpha);
			}
			else{
				fill(panelColor, LowAlpha);
			}
			rect(x, y, PanelWidth, PanelHeight);
			
			fill(textColor);
			textAlign(CENTER,CENTER);
			textSize(textSize);
			text(str, x + PanelWidth / 2, y + PanelHeight / 2);
		}
	}
	
}

private class Stage extends Select{ //セッター書くのがだるかったので上のを継承させた
	final color EdgeColor = color(255, 100, 100);
	
	boolean select;
	
	//constructor
	Stage() {}
	Stage(int x, int y) {
		super();
		this.PanelWidth = 100;
		this.PanelHeight = 100;
		this.textSize = 20;
		this.textColor = color(100, 0, 0);
		this.DefaultColor = color(100, 100, 100);
		
		this.x = x;
		this.y = y;
		this.panelColor = DefaultColor;
		this.select = false;
	}
	
	Stage(int x, int y, String str) {
		this(x, y);
		StringBuilder sb = new StringBuilder();  //ステージ名が長いと資格をはみ出るため、無理やり改行文字を埋め込む
		int charlimit = 6; //6文字ごと
		sb.append(str);
		if (str.length() > charlimit) {
			for (int i = str.length(); i >= 0; i -= charlimit) {
				if (i ==  str.length()) {continue;}
				sb.insert(i,"\n");
			}
			str = sb.toString();
			
		}
		this.str = str;
	}
	
	Stage(int x, int y, String str, color c) {
		this(x, y, str);
		this.panelColor = c;
	}
	
	public void select() {
		this.select = true;
	}
	
	public void unselect() {
		this.select = false;
	}
	
	@Override
	public void draw() {
		if (this.onMouse()) {
			fill(panelColor, HighAlpha);
		}
		else{
			fill(panelColor, LowAlpha);
		}
		rect(x, y, PanelWidth, PanelHeight);
		
		strokeWeight(4);
		stroke(EdgeColor);
		fill(0, 0, 0, 0);
		if (select) {
			rect(x - 2, y - 2, PanelWidth + 2, PanelHeight + 2);
		}
		strokeWeight(1);
		stroke(0);
		
		fill(textColor);
		textAlign(CENTER,CENTER);
		textSize(textSize);
		text(str, x + PanelWidth / 2, y + PanelHeight / 2);
	}
}
