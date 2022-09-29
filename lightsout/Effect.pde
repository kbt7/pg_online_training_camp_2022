public class ClearEffect {
	private Particle[] particle;
	private int pSize = 10;
	private int d;
	private color backgroundColor = color(255,200,200);
	public ClearEffect(int n) {
		this.particle = new Particle[n];
		d = width / n;
		for (int i = 0;i < n;i++) {
			// this.particle[i] = new Particle(d * i,(int)random( -500,0),(int)random( -20,20),(int)random(7) + 20,this.pSize + (int)random(10),color((int)random(200,255),255,(int)random(255)));
			this.particle[i] = new Particle(this.pSize + (int)random(10),color((int)random(150,255),255,(int)random(255)));
			this.particle[i].setXY(d * i,(int)random( -500,0));
			this.particle[i].setSpeed((int)random( -20,20),(int)random(7) + 20);
		}
	}
	
	public void draw() {
		//println(this.particle.length);
		background(this.backgroundColor);
		for (int i = 0;i < this.particle.length;i++) {
			this.particle[i].reverseMove();
			this.particle[i].draw();
		}
	}
}

//粒
public class Particle{
	int size = 5;
	color c = color(255,0,0);
	int x,y;
	int vx,vy;
	
	public Particle(int size,color c) {
		this.size = size;
		this.c = c;
	}
	
	public Particle(int x,int y,int vx,int vy,int size, color c) {
		this(size,c);
		this.x = x;
		this.y = y;
		this.vx = vx;
		this.vy = vy;
		
	}
	
	public void draw() {
		fill(this.c);
		noStroke();
		ellipse(this.x,this.y,this.size,this.size);
		stroke(0);
	}
	
	public void move() {
		this.x += this.vx;
		this.y += this.vy;
	}
	
	public void reverseMove() {
		this.x += this.vx;
		this.y += this.vy;
		if (this.y > height) {
			this.y = (int)random(5);
		}
		if (this.x > width) {
			this.x = 0;
		}
	}
	
	//setter
	public void setXY(int x,int y) {
		this.x = x;
		this.y = y;
	}
	
	public void setSpeed(int vx,int vy) {
		this.vx = vx;
		this.vy = vy;
	}
	public void setColor(color c) {
		this.c = c;
	}
	
	//getter
	public int getvx() {
		return this.vx;
	}
	public int getvy() {
		return this.vy;
	}
}

public class ClickEffect{
	
	private Particle[] particle;
	private int pSize = 8;
	private color pColor = color(255,0,255);
	private int n;
	
	public ClickEffect(int n) {
		this.n = n;
		particle = new Particle[n];
		for (int i = 0;i < n;i++) {
			particle[i] = new Particle(pSize,pColor);
			particle[i].setXY( -9999, -9999);
			particle[i].setSpeed(0,0);
		}
	}
	
	public void start() {
		for (int i = 0;i < this.n;i++) {
			particle[i] = new Particle(pSize,pColor);
			particle[i].setXY(mouseX,mouseY);
			particle[i].setSpeed((int)random( -5,5),(int)random( -13));
			particle[i].setColor(color(random(150),random(150),150));
		}
	}
	
	public void draw() {
		for (int i = 0;i < this.n;i++) {
			this.particle[i].move();
			this.particle[i].setSpeed(this.particle[i].getvx(),this.particle[i].getvy() + 1);
			this.particle[i].draw();
		}
	}
}
