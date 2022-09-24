Scene scene;

void setup() {
	size(800, 600);
	scene = new Scene();
}

void draw() {
  background(125);
  scene.operate();
	scene.draw(); //<>//
}

public PApplet getPApplet() { //Audio.pdeのMinimライブラリの初期化にProcessing自身のインスタンスが必要なため追加
	return this;
}
