//import processing.sound.*;
//SoundFile file;

class Ball {
  float x, y; // 座標
  float width, height; // ballの幅と高さ
  float vx, vy; // vxはx方向の速度、vyはy方向の速度
  //float col; // 
  float r, g, b; //  red, green, blue。 fill用に使う
  float ax, ay; // axはx方向の加速度, ayはy方向の加速度
  float gravity; // 重力加速度
  boolean visible; // 描画するかどうか(背景色に合わせるか否か)を表す
  boolean enableGravity; // 重力を適用するかどうか

  Ball() { //  ballの初期化を行う。visibleの定義のみ
    this.visible = true; // 初期値はtrue
  }

  void move() { // 花火の移動を担う。呼ばれるたびに移動する。(これだけでは描画はされない)
    this.x += vx;
    this.y += vy;
    this.vx += ax;
    this.vy += ay;
  }

  void draw() { // 実際の描画処理
    this.setVisible(); // 速度が0に近づいたら、visibleをfalseに書き換える
    if (visible){ // trueであれば、何もしない
     
    }
    else{ // falseであれば、destroy(背景色と同化させる)
         this.destroy();
    }
    
    fill(r, g, b); // 塗りつぶし。直後に呼ばれた図形描画処理(ellipse, rectなど)に対して適用される。
    ellipse(x, y, width , height);
  }
  
  void setVisible(){ // 速さが0に近づいた時に、this.visible = falseにする
       if (-0.5 < this.vx && this.vx < 0.5 && -0.5 < this.vy  &&  this.vy < 0.5){
         this.visible = false;
       }
  }
  

  void destroy() { // red, green, blue全てに0を設定することで、見えなくする
    this.r = 0;
    this.b = 0;
    this.g = 0;
    
  }
}

class Circle {
  float accel;
  int balls_num; 
  ArrayList<Ball> balls;
  float speed; // 速さ。サークルに持たせることで、そのサークルに属するballsに対して同じ速度を持たせることが
  float explode_point_x; // 爆発座標x
  float explode_point_y; // 爆発座標y
  float r,g,b; // circleの持つr,g,b
  boolean dead;

  Circle() { // ballの数と、ballsリストにインスタンス(プロパティ未設定)を入れておく。
    this.balls_num = 16;
    initBalls();
  }

  void initBalls() { // ballsにインスタンスを入れる。プロパティはまだ設定されていない
    this.balls = new ArrayList<Ball>(); 
    for (int i = 0; i < this.balls_num; i++) {
      this.balls.add(new Ball());
    }
  }

  void setBalls() { // ballsにプロパティを入れる
    for (int i = 0; i < this.balls.size(); i++){ 
      balls.get(i).x = this.explode_point_x; // ballの初期位置は爆発地点と等しく
      balls.get(i).y = this.explode_point_y; // 
      balls.get(i).height = 5;
      balls.get(i).width = 5;
      balls.get(i).r = this.r;
      balls.get(i).g = this.g;
      balls.get(i).b = this.b;
      balls.get(i).vx = this.speed*cos(((float)i/this.balls.size())*3.14*2); // x座標の速さを設定。式はslack参照
      balls.get(i).vy = this.speed*sin(((float)i/this.balls.size())*3.14*2); // y座標の速さを設定
      balls.get(i).ax = this.accel*cos(((float)i/this.balls.size())*3.14*2); //  x座標の加速度を設定
      balls.get(i).ay = this.accel*sin(((float)i/this.balls.size())*3.14*2); // y座標の加速度を設定
    }
    
  }

  void setExplodePoint(float explode_point_x, float explode_point_y) { // circleの爆発地点をset
    this.explode_point_x = explode_point_x; 
    this.explode_point_y = explode_point_y;
  }

  void setSpeed(float speed) { // サークルの速度をセット。
    this.speed = speed;
  }

  void setAccel(float accel) { // サークルの加速度をセット
    this.accel = accel;
  }



  void draw() { // ボールの移動と描画を実際に行う。
    int dead_num = 0;
    for (int i = 0; i < this.balls.size(); i++) { 
      //println(str(i) + str(balls.get(i).vx));
      balls.get(i).move();
      balls.get(i).draw();
      
      if (!balls.get(i).visible){
        dead_num += 1;
        if (dead_num == this.balls.size()){
        this.dead = true;
        }
      }
    }
  }
}

class Fireworks {
  Ball origin; 
  float r,g,b; 
  int circle_num = 5; // サークルの数。
  float explode_point; // 爆発地点
  Circle[] circles;
  boolean dead;

  Fireworks() { // originの定義。circlesリストにインスタンス(プロパティ未設定)をとりあえずcircle_num分作っとく
    this.origin = new Ball();
    //this.circles = {new Circle(), new Circle()}
    origin.r = random(0, 255);
    origin.g = random(0, 255);
    origin.b = random(0, 255);
    origin.vy = -1000;
    origin.vx = 0;
    origin.ay = 0;
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
      float accel = (float)(((i+1 ) * -0.1));
      this.circles[i].setSpeed((float)5);
      this.circles[i].setAccel(accel);
      this.circles[i].setExplodePoint(this.origin.x, this.explode_point);
      this.circles[i].r = this.origin.r;
      this.circles[i].g = this.origin.g;
      this.circles[i].b = this.origin.b;
      this.circles[i] .setBalls();
    }
  }

  void setOriginPointAndSize(float x, float y, float width, float height) { // 花火の元となるoriginの座標とサイズを定義する
       this.origin.x = x;
       this.origin.y = y;
       this.origin.width =width;
       this.origin.height = height;
  }

  void play() { // 花火の一生を担う //<>//
    origin.move(); // originballを動かす。
    if (this.origin.y > explode_point) { 
      origin.draw(); 
    } else if (this.origin.y == explode_point) { // 
      origin.draw();
    } else {
      this.explode();
    }
  }

  void explode() {
    int dead_num = 0;
    for (int i = 0; i < this.circles.length; i++) {
      this.circles[i].draw();
      if (this.circles[i].dead){
        dead_num += 1;  
        //print("cirlcleは死んだ");
        if (dead_num == this.circles.length){
        this.dead = true;
        //print("circlesは死んだ");
        }
      }
    }
  }
}

//Fireworks fw = new Fireworks();
//Fireworks fw2 = new Fireworks();


void setup() {
    size(500, 500);
}


ArrayList<Fireworks> fw_list = new ArrayList<Fireworks>(); // 花火のインスタンスが格納される。
ArrayList<Integer> dead_fw_list_index = new ArrayList<Integer>(); // 死んだ花火のインデックスを格納する
float generate_probability = 30; // 一度のdraw処理の中で、花火が生み出される確率。出現頻度を変えたいときはここをいじる

void draw() {

  background(0, 0, 0); // 直前のフレームの削除
  
 
  /*
  花火の描画処理
  */
  if (fw_list.size() != 0){
      for (int i = 0; i < fw_list.size(); i++){
        fw_list.get(i).play(); 
        if (fw_list.get(i).dead){ // 花火が死んでいたら(所持するcircleのballsが全てvisible=falseなら)
          dead_fw_list_index.add(i); // 死んだ花火のインデックスを持つリストに格納する。
        }
      }
  }
  
  /* 死んだ花火を削除する
  1. dead_fw_list_indexの中身をfor文で一つずつ取り出し
  2. remove処理を行う。
  3. dead_fw_list_indexの要素を全て削除。次のdraw処理ですでになくなっているfw_listのインデックス(そのインデックスには、もう別のインスタンスが割り当てられている)をもう一度削除しようとするのを防ぐため。
  */
  for (int dead_fw_index : dead_fw_list_index){
    fw_list.remove(dead_fw_index);
  }
  dead_fw_list_index.clear();
  
  /*
  ランダムな時間に生成する処理。
  1. 乱数を生成
  2. generate_probability(発生確率)以下であれば、新しいFireworksのインスタンスを生み出し、初期値を定義してfw_listに格納する。
  以外であれば、何も起きない(次のdraw処理に移行)。
  */
  float num  = random(0, 100);
  if (num < generate_probability){
    Fireworks fw = new Fireworks(); // 
    fw.explode_point = random(0, 500); //  爆発地点を設定
    fw.setOriginPointAndSize(random(0, 500), 500f, 10.0f, 10.0f);  // originのサイズと座標を設定
    fw.setCircles(); // 
    fw_list.add(fw);
  }

}
