Scene scene;

void setup() {
	size(800, 600);
	scene = new Scene();
	PFont font = createFont("MS Gothic",50);
	textFont(font);
}

void draw() {
	background(125);
	//scene.operate();
	scene.draw(); //<>//
}

boolean isPressed = false;

void mousePressed() {
	if (!isPressed) {
		Audio se = new Audio("Audio/SE/SE_Click.mp3"); //この感じでseをSceneのローカル変数にすると動くがこいつらを上にずらしてグローバル変数にするとエラーが出で動かなくなる原因不明
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
