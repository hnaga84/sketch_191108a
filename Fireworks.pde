import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.*;



class Fireworks {
  Ball origin; 
  float r,g,b; 
  int circle_num = 5; // サークルの数。
  float explode_point; // 爆発地点
  Circle[] circles;
  boolean dead;
  //Minim minim;
  AudioPlayer player;

  Fireworks() { // originの定義。circlesリストにインスタンス(プロパティ未設定)をとりあえずcircle_num分作っとく
    //this.minim = new Minim(this);
    this.player =  minim.loadFile("hanabisakuretu.mp3");
    this.origin = new Ball();
    origin.r = random(0, 255);
    origin.g = random(0, 255);
    origin.b = random(0, 255);
    origin.vy = -100;
    origin.vx = 0;
    origin.ay = -100;
    origin.ax = 0;

    this.initCircles();
  }
  
  void initCircles(){ // circlesの初期化。(全てのプロパティが未設定のインスタンスを持つリストを作成)
    this.circles = new Circle[this.circle_num];
    for (int i = 0; i < this.circles.length; i++){
      circles[i] = new Circle();
    }
  }

  void setCircles() { // 各サークルのプロパティを設定
    for (int i = 0; i < this.circles.length; i++) {
      float accel = (float)(((i+1 ) * 1));
      this.circles[i].setSpeed((float)5 + accel);
      this.circles[i].setAccel(accel);
      this.circles[i].setExplodePoint(this.origin.x, this.explode_point);
      this.circles[i].r = this.origin.r;
      this.circles[i].g = this.origin.g;
      this.circles[i].b = this.origin.b;
      this.circles[i].setBalls();
    }
  }

  void setOriginPointAndSize(float x, float y, float width, float height) { // 花火の元となるoriginの座標とサイズを定義する
       this.origin.x = x;
       this.origin.y = y;
       this.origin.width = width;
       this.origin.height = height;
  }

  void play() { // 花火の一生を担う
    origin.move(); // originballを動かす。
    if (this.origin.y > explode_point) { 
      origin.draw(); 
    } else if (this.origin.y == explode_point) { // 
      origin.draw();
    } else {
       player.play();
      this.explode();
    }
  }

  void explode() {
    int dead_num = 0;
    for (int i = 0; i < this.circles.length; i++) {
      this.circles[i].draw();
      if (this.circles[i].dead){ 
        dead_num += 1;  
        if (dead_num == this.circles.length){
          this.dead = true;
        }
      }
    }
  }
}
