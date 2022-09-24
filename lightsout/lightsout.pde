Scene scene;
TextLoad load;

void setup() {
	size(800, 600);
	scene = new Scene();
  load = new TextLoad();
  load.mapLoad(2);
}

void draw() {
	scene.operate();
	scene.drawScene();
}

public PApplet getPApplet() { //Audio.pdeのMinimライブラリの初期化にProcessing自身のインスタンスが必要なため追加
	return this;
}
