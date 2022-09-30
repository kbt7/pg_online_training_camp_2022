public class Select{
	protected int PanelWidth = 500;
	protected int PanelHeight = 50;
	protected color DefaultColor = color(100, 255, 100);
	final int HighAlpha = 255;
	final int LowAlpha = 150;
	protected color textColor = color(255, 0, 0);
	protected int textSize = 30;
	private boolean state; //クリックされる項目が有効か無効か設定できる
	private Audio onMouseSe;
	
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
		
		this.onMouseSe = new Audio("Audio/SE/SE_OnMouse.mp3");
		this.onMouseSe.setVolume( -20);
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
				this.onMouseSe.play();
			}
			else{
				this.onMouseSe.rewind();
				this.onMouseSe.pause();
				fill(panelColor, LowAlpha);
			}
			strokeWeight(1);
			rect(x, y, PanelWidth, PanelHeight);
			
			fill(textColor);
			textAlign(CENTER,CENTER);
			textSize(textSize);
			text(this.str, x + PanelWidth / 2, y + PanelHeight / 2);
			//println(this.str);
		}
	}
	
}

public class Stage extends Select{ //セッター書くのがだるかったので上のを継承させた
	final color EdgeColor = color(255, 100, 100);
	
	boolean select;
	
	
	//constructor
	Stage() {}
	Stage(int x, int y) {
		super(x,y);
		this.PanelWidth = 100;
		this.PanelHeight = 100;
		this.textSize = 20;
		this.textColor = color(100, 0, 0);
		this.DefaultColor = color(100, 100, 100);
		
		this.x = x;
		this.y = y;
		this.panelColor = DefaultColor;
		this.select = false;
		super.setState(true);
	}
	
	Stage(int x, int y, String str) {
		// this(x, y);
		// StringBuilder sb = new StringBuilder();  //ステージ名が長いと資格をはみ出るため、無理やり改行文字を埋め込む
		// int charlimit = 6; //6文字ごと
		// sb.append(str);
		// if (str.length() > charlimit) {
		// 	for (int i = str.length(); i >= 0; i -= charlimit) {
		// 		if (i ==  str.length()) {continue;}
		// 		sb.insert(i,"\n");
		// 	}
		// 	str = sb.toString();
		// }
		// this.str = str;
		this(x,y);
		//StringBuilder sb = new StringBuilder(); //'_'(アンダーバー)で改行する
		//sb.append(this.str);
		for (int i = 0;i < this.str.length();i++) {
			if (this.str[i] ==  '_') {
				this.str[i] = '\n';
			}
		}
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
		super.draw();
		strokeWeight(1);
		stroke(0);
		noFill();
		rect(x , y , PanelWidth , PanelHeight);
		fill(0);
		strokeWeight(5);
		stroke(EdgeColor);
		fill(0, 0, 0, 0);
		if (select) {
			rect(x - 2, y - 2, PanelWidth + 2, PanelHeight + 2);
		}
	}
}
