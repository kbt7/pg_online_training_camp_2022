import ddf.minim.*;  //minimライブラリのインポート

public class Audio{
	private Minim minim;  //Minim型変数であるminimの宣言
	private AudioPlayer player;  //サウンドデータ格納用の変数
	private String fileName;
	
	public Audio(String fileName) {
		this.minim = new Minim(getPApplet());  //初期化
		this.fileName = fileName;
		this.player = this.minim.loadFile(this.fileName); //sample.mp3をロードする
	}
	
	public void play() { //鳴らす
		this.player.play();
	}
	
	public void setVolume(float gain) { //音量調整
		//player.setVolume(volume); //音量0-1で調整 これはやってみたけど僕の環境だと音量変えられなかったなんで？
		this.player.setGain(gain); //音量をGainで調整する、このGainがPCの環境依存らしいから調整できる範囲はPCの環境によって変わるクソ仕様(僕のPCだと-20くらいで音量30%位になる)
	}
	
	public boolean isPlaying() { //再生中true,それ以外falseをreturn
		return this.player.isPlaying();
	}
	
	public void end() { //再生停止
		this.player.close();  //サウンドデータを終了
		this.minim.stop();
		//super.stop(); //コピペのプログラムに書いてあった。コメントアウトしないとエラー
	}
	public void pause() {
		this.player.pause();
	}
	public void rewind() {
		this.player.rewind();
	}
}
