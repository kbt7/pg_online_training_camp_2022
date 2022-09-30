PShader sd;

private enum GameMode{
	TITLE,
	PLAY,
	SELECT,
	RESULT,
	END
};

public class Scene{
	MainGame mainGame;
	TextLoad load;
	private GameMode gameMode;

	private Select title, gamePlay, select, result, exit, nextPage, previousPage;
	private Stage[] stage;
	private Stage[] randomStage;
	private final int RANDOMSELECT = 100;
	private int stageLimit = 4; //ステージセレクトで１画面に表示する最大数
	private int page = 1; //ステージセレクトで表示する現在のページ
	private int t1; //ゲーム終了時のメッセージ表示用millis()
	private String[] scores;
	PGraphics pg;
	float[][] sc;

  PImage img;

	private int pickStage;
	//private boolean isPressed;

	private ClearEffect clearEffect;

	Scene() {
    img = loadImage("image/title.png");
		title = new Select(0, 100, "↩");
		gamePlay = new Select(0, 200, "GAME START");
		select = new Select(0, 250, "STAGE SELECT");
		result = new Select(0, 300, "RESULT");
		exit = new Select(0, 500, "EXIT");
		nextPage = new Select(700,500, "→");  //ステージセレクト右
		previousPage = new Select(50,500,"←");  //ステージセレクト左
		nextPage.setPanelSize(50,50);
		previousPage.setPanelSize(50,50);
		title.setPanelSize(50,50);

		sd = loadShader("shader.frag");

		title.setGameMode(GameMode.TITLE);
		gamePlay.setGameMode(GameMode.PLAY);
		select.setGameMode(GameMode.SELECT);
		result.setGameMode(GameMode.RESULT);
		exit.setGameMode(GameMode.END);

		pickStage = 0;

		sc = new float[5][];

		this.clearEffect = new ClearEffect(100);

		load = new TextLoad();
		stage = new Stage[load.fileNames.length];
		randomStage = new Stage[2];
		randomStage[0] = new Stage(540, 200, "ランダム_3×3");
		randomStage[1] = new Stage(660, 200, "ランダム_5×5");
		int stagecount = 0;
		for (int i = 0; i < load.fileNames.length; i++) {
			stage[i] = new Stage(stagecount * 120 + 170, 400, split(load.fileNames[i], ".")[0]);
			stagecount++;
			if (stagecount > 3) { //4ステージごとに位置リセット
				stagecount = 0;
			}
			if (i == pickStage) {
				stage[i].select();
			}
		}
		if (pickStage >= RANDOMSELECT) {
			randomStage[pickStage - RANDOMSELECT].select();
		}

		gameMode = GameMode.TITLE;

		pg = createGraphics(width, height);
		pg.beginDraw();
		pg.background(0);
		pg.textAlign(TOP, LEFT);
		pg.fill(255);
		pg.textSize(50);
		pg.text("LIGHTS OUT", 50, 50);
		pg.endDraw();
		sd.set("iTex",pg);
		sd.set("iResolution",(float)width,(float)height);
	}

	public void drawScene() {
		title.draw();
		mainGame.drawPanel();
		if (mainGame.goalExist()) mainGame.goalPanel();
	}

	private void titleDraw() {
		t1 = millis();
    image(img, 0, 0, width, height);
		sd.set("iTime", millis() / 1000.0);
		shader(sd);
		rect(0, 0, width, height);
		resetShader();
    tint(64+255*abs(sin(t1/1000.0)));//割る数値を変更すれば変更頻度が変わる
		resetShader(); 
		select.draw();
		exit.draw();
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
		for (int i = 0; i < randomStage.length; i++) {
			randomStage[i].draw();
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
		clearEffect.draw();
		textAlign(TOP,RIGHT);
		fill(0);
		text("Game Clear!" + "\n" + "手数　" + mainGame.getCount() + "\n" + "経過時間　" +
		  (mainGame.finish - mainGame.start) / 1000 + "\n" + "～SCORE～" + "\n" + "順位 " + "手数 " + "時間", 525, 35);
		for (int i = 0; i < scores.length; i++) {
			if (i == load.getRank()) {
				fill(255, 0, 0);
			} else {
				fill(0);
			}
			text((i + 1), 525, 150 + (i + 1) * 75);
		  text((int)sc[i][0],600, 150 + (i + 1) * 75);
		  text(sc[i][1],660, 150 + (i + 1) * 75);
		}

		title.draw();
		exit.draw();
		select.draw();

	}

	public void operate() {
		switch(gameMode) {
			case TITLE:
				if (select.onMouse()) {
					gameMode = select.getGameMode();
				}
				if (exit.onMouse()) {
					gameMode = exit.getGameMode();
				}
				break;
			case SELECT:
				if (gamePlay.onMouse()) {
			     if (mainGame != null) {
					    mainGame.clear();
					    mainGame = null;
					    System.gc();
					  }
					if (pickStage >= RANDOMSELECT) {
					    if (pickStage == RANDOMSELECT) {
							mainGame = new MainGame(3, 3);
						    mainGame.randomMap(5);
						  } else {
						    mainGame = new MainGame(5, 5);
						    mainGame.randomMap(10);
						  }

						mainGame.start = millis();
					} else {
						mainGame = new MainGame(load.mapLoad(pickStage));//本来はゲームプレイ用のシーンでインスタンス生成
						if (load.goalExist[pickStage]) mainGame.setGoalPanel(load.goalLoad(pickStage));
						mainGame.start = millis();
					}
					gameMode = gamePlay.getGameMode();
				}
				if (title.onMouse()) {
					gameMode = title.getGameMode();
				}
				for (int i = (page - 1) * 4; i < (page - 1) * 4 + 4; i++) {
					if (i < load.fileNames.length) {
						if (stage[i].onMouse()) {
							if (pickStage >= RANDOMSELECT) {
						      randomStage[pickStage - RANDOMSELECT].unselect();
							} else {
								stage[pickStage].unselect();
							}
							pickStage = i;
							stage[i].select();
						}
					}
				}
		    for (int i = 0; i < randomStage.length; i++) {
					if (randomStage[i].onMouse()) {
						if (pickStage != RANDOMSELECT + i) {
						    if (pickStage < RANDOMSELECT) {
								stage[pickStage].unselect();
						    } else {
						      randomStage[pickStage - RANDOMSELECT].unselect();
						    }
						}
						pickStage = RANDOMSELECT + i;
						randomStage[i].select();
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
				mainGame.finish = millis();
				mainGame.selectPanel();
				if (mainGame.stageClear()) {
					gameMode = GameMode.RESULT;//ゲームクリア画面に移行//

					if (pickStage >= RANDOMSELECT) {
						load.saveScore(randomStage[pickStage - RANDOMSELECT].str, mainGame.getCount(),(mainGame.finish - mainGame.start) / 1000);
						scores = load.loadScore(randomStage[pickStage - RANDOMSELECT].str);
					} else {
						load.saveScore(load.getFileName(pickStage), mainGame.getCount(),(mainGame.finish - mainGame.start) / 1000);
						scores = load.loadScore(load.getFileName(pickStage));
					}
			     for (int i = 0; i < scores.length; i++) {
					    sc[i] = float(split(scores[i], " "));
					  }
				}
				if (title.onMouse()) {
					gameMode = title.getGameMode();
				}
				break;
			case RESULT:
				if (title.onMouse()) {
					gameMode = title.getGameMode();
				}
				if (exit.onMouse()) {
					gameMode = exit.getGameMode();
				}
				if (select.onMouse()) {
					gameMode = select.getGameMode();
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
	// 				else if (exit.onMouse()) {
	// 					gameMode = exit.getGameMode();
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
	// 				else if (exit.onMouse()) {
	// 					gameMode = exit.getGameMode();
	// 				}
	// 			}
	// 			if (!mousePressed) isPressed = false;
	// 			break;
	// 		default:
	// 		break;
	// 	}
	// }

	public void draw() {
		strokeWeight(1);
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
	    fill(0);
				text("See you next time!", width / 2, height / 2);
				if (millis() - t1 > 1000) {
					exit();
				}
				break;
		}
	}

	//getter
	public GameMode getGameMode() {
		return this.gameMode;
	}
}
