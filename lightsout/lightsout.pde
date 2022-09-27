Scene scene;

Audio se;
Audio mainBgm;
Audio titleBgm;
Audio resultBgm;

void setup() {
	size(800, 600);
	scene = new Scene();
	PFont font = createFont("MS Gothic",50);
	textFont(font);
	
	// Audio se = new Audio("testSE.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
	se = new Audio("Audio/SE/SE_Click.mp3");
	titleBgm = new Audio("Audio/BGM/BGM_Title.mp3");
	mainBgm = new Audio("Audio/BGM/BGM_Main.mp3");
	resultBgm = new Audio("Audio/BGM/BGM_Result.mp3");
	
	titleBgm.setVolume( -20);
	mainBgm.setVolume( -20);
	resultBgm.setVolume( -20);
} //<>//

void draw() {
	background(125);
	//scene.operate();
	scene.draw(); //<>//
	playBGM();
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
		se.rewind();
		se.setVolume( -20);
		se.play();
		
		scene.operate(); //マウスボタンが離れた瞬間に一回呼ばれる
		isPressed = true;
	}
}
void mouseReleased() {
	isPressed = false;
}

public PApplet getPApplet() { //Audio.pdeのMinimライブラリの初期化にProcessing自身のインスタンスが必要なため追加
	return this;
}

void dispose() { //プログラム終了時処理
	se.end();
	mainBgm.end();
	titleBgm.end();
	resultBgm.end();
}
