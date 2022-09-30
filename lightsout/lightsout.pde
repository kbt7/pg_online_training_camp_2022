Scene scene;

Audio clickSe;
Audio panelClickSe;
Audio mainBgm;
Audio titleBgm;
Audio resultBgm;

ClickEffect clickEffect;


void setup() {
	size(800, 600, P2D);
	scene = new Scene();
	PFont font = createFont("MS Gothic",50);
	textFont(font);
	
	// Audio se = new Audio("testSE.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
	clickSe = new Audio("Audio/SE/SE_Click.mp3");
	panelClickSe = new Audio("Audio/SE/SE_PanelClick.mp3");
	titleBgm = new Audio("Audio/BGM/BGM_Title.mp3");
	mainBgm = new Audio("Audio/BGM/BGM_Main.mp3");
	resultBgm = new Audio("Audio/BGM/BGM_Result.mp3");
	
	titleBgm.setVolume( -20);
	mainBgm.setVolume( -20);
	resultBgm.setVolume( -20);
	panelClickSe.setVolume( -10);
	clickSe.setVolume( -20);
	
	clickEffect = new ClickEffect(10);
} //<>//

void draw() {
	background(125);
	//scene.operate();
	scene.draw(); //<>//
	playBGM();
	clickEffect.draw();
	
}

// TITLE,
// PLAY,
// SELECT,
// RESULT,
// END
void playBGM() {
	switch(scene.getGameMode()) {
		case TITLE:
			if (!titleBgm.isPlaying()) {
				mainBgm.pause();
				resultBgm.pause();
				titleBgm.rewind();
				titleBgm.play();
			}
			break;
		case PLAY:
			if (!mainBgm.isPlaying()) {
				titleBgm.pause();
				resultBgm.pause();
				mainBgm.rewind();
				mainBgm.play();
			}
			break;
		case SELECT:
			if (!titleBgm.isPlaying()) {
				mainBgm.pause();
				resultBgm.pause();
				titleBgm.rewind();
				titleBgm.play();
			}
			break;
		case RESULT:
			if (!resultBgm.isPlaying()) {
				mainBgm.pause();
				titleBgm.pause();
				resultBgm.rewind();
				resultBgm.play();
			}
			break;
		case END:
			break;
		default:
		break;
	}
}

boolean isPressed = false;

//Audio se = new Audio("Audio/SE/SE_Click.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
void mousePressed() {
	if (!isPressed) {
		if (scene.getGameMode() ==  GameMode.PLAY) {
			panelClickSe.rewind();
			panelClickSe.play();
		} else{
			clickSe.rewind();
			clickSe.play();
		}
		
		scene.operate(); //マウスボタンが離れた瞬間に一回呼ばれる
		isPressed = true;
		clickEffect.start();
	}
}
void mouseReleased() {
	isPressed = false;
}

public PApplet getPApplet() { //Audio.pdeのMinimライブラリの初期化にProcessing自身のインスタンスが必要なため追加
	return this;
}

void dispose() { //プログラム終了時処理
	clickSe.end();
	panelClickSe.end();
	mainBgm.end();
	titleBgm.end();
	resultBgm.end();
}
