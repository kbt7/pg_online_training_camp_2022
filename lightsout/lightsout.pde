Scene scene;

Audio se;

void setup() {
	size(800, 600);
	scene = new Scene();
	PFont font = createFont("MS Gothic",50);
	textFont(font);
	se = new Audio("Audio/SE/SE_Click.mp3");
} //<>//

void draw() {
	background(125);
	//scene.operate();
	scene.draw(); //<>//
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
	scene.mainBgm.end();
	scene.titleBgm.end();
}
