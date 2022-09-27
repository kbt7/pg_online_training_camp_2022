import java.util.Arrays;
import java.util.Iterator;
import java.util.Collections;

class MainGame{
	int[][] panel;
	int h,w,panelSize = 100;
	boolean isPressed;
  int count = 0;
  private float start = 0;
  private float finish = 0;

  
  public int getCount(){
    return count;
  }
	
	MainGame() {
		h = 5;
		w = 5;
		panel = new int[w][h];
		isPressed = true;
	}
	
	MainGame(int[][] map) {
		h = map[0].length;
		w = map.length;
		panel = map;
		isPressed = true;
	}
	
	MainGame(int x, int y) {
		w = x;
		h = y;
		panel = new int[w][h];
		isPressed = true;
	}
	
	public void randomMap(int turn) {
		if (turn > w * h) turn = w * h;
		int[][] turnMap = new int[w][h];
		ArrayList<Integer> list = randomNumber(w * h);
		Iterator<Integer> itr = list.iterator();
		
		for (int i = 0; i < turn; i++) {
			int n = itr.next();
			turnMap[n % w][n / w] = 1;
		}
		
		for (int i = 0; i < h; i++) {
			for (int j = 0; j < w; j++) {
				int n = 1;
				if (i != 0) n += turnMap[j][i - 1];
				if (i != h - 1) n += turnMap[j][i + 1];
				if (j != 0) n += turnMap[j - 1][i];
				if (j != w - 1) n += turnMap[j + 1][i];
				n += turnMap[j][i];
				panel[j][i] = n & 1;
			}
		}
	}
	
	public ArrayList<Integer> randomNumber(int n) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		for (int i = 0; i < n; i++) {
			list.add(i);
		}
		Collections.shuffle(list);
		
		return list;
	}
	
	public void drawPanel() {
		for (int i = 0; i < w; i ++) {
			for (int j = 0; j < h; j ++) {
				if (panel[i][j] == 0) {
					 fill(128);
				}
				else if (panel[i][j] == 1) {
					 fill(255);
				}
				rect(i * panelSize + width / 2 - w / 2.0 * panelSize,j * panelSize + height / 2 - h / 2.0 * panelSize,panelSize,panelSize);
			}
		}
    textAlign(TOP, LEFT);
    fill(0);
    text("手数　" + count + "　経過時間　" + (millis()-start)/1000, 50, 50);
	}

/*
	public void goalPanel() {                        ///////////////////////// 目標の形の描画
		for (int i = 0; i < h; i ++) {
			for (int j = 0; j < w; j ++) {
				if (samplepanel[j][i] == 0) {
					 fill(128);
				}
				else if (samplepanel[j][i] == 1) {
					 fill(255);
				}
				rect(i * panelSize / 2,j * panelSize / 2 + height / 2 - h / 2.0 * panelSize / 2,panelSize / 2,panelSize / 2);
			}
		}
	}
*/	

	public boolean stageClear() {
		for (int i = 0; i < w; i ++) {
			for (int j = 0; j < h; j ++) {
				if (panel[i][j] == 0) {
					 return false;                 //未達成
					 }
				}
		}
		return true;                        //達成
	}
	
	public boolean stageClear(int[][] stage) { // int[][] stageはテキストファイルなどに用意する
		for (int i = 0; i < w; i ++) {
			for (int j = 0; j < h; j ++) {
				if (panel[i][j] != stage[i][j]) {
					 return false;                 //未達成
				}
			}
		}
		return true;                        //達成
	}
	
	public void selectPanel() {
		if (mouseX < w * panelSize + width / 2 - w / 2.0 * panelSize &&  mouseX >=  width / 2 - w / 2.0 * panelSize && 
			mouseY < h * panelSize + height / 2 - h / 2.0 * panelSize &&  mouseY >=  height / 2 - h / 2.0 * panelSize) {
      count ++;
			int selectX = (mouseX - width / 2 + (int)(w / 2.0 * panelSize)) / panelSize;
			int selectY = (mouseY - height / 2 + (int)(h / 2.0 * panelSize)) / panelSize;
			turnPanel(selectX, selectY);
			turnPanel(selectX + 1, selectY);
			turnPanel(selectX - 1, selectY);
			turnPanel(selectX, selectY + 1);
			turnPanel(selectX, selectY - 1);
			isPressed = true;
		}
	}
	public void turnPanel(int x, int y) {
		if (x < w && x >= 0 && y < h && y >= 0) {
			panel[x][y] ^= 1;
		}
	}
}
