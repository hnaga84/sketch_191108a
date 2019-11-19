class Ball {
  float x, y; // 座標
  float width, height; // ballの幅と高さ
  float vx, vy; // vxはx方向の速度、vyはy方向の速度
  float r, g, b; //  red, green, blue。 fill用に使う
  float opacity = 255; // この値が大きければ大きいほど、不透明である。
  float ax, ay; // axはx方向の加速度, ayはy方向の加速度
  float gravity = 0.1; // 重力加速度
  float air_resist_const = 0.001;
  boolean visible; // 描画するかどうか(背景色に合わせるか否か)を表す
  boolean enableGravity; // 重力を適用するかどうか
  int ORBIT_NUM = 10; // 引く尾の数。高いと尾が長くなる。また、orbitに格納するインスタンスの最大数でもある
  ArrayList<Ball> orbit = new ArrayList<Ball>(); // 自分自身のballインスタンスの履歴を格納する。
  

  Ball() { //  ballの初期化を行う。visibleの定義のみ
    this.visible = true; // 初期値はtrue
  }
  
  void addOrbit(Ball ball){ 
    if (this.orbit.size() < ORBIT_NUM){
      orbit.add(ball);
    }else{
      orbit.remove(0);
      orbit.add(ball);
    }
  }
  
  void setPoint(float x, float y){ // 座標のsetterメソッド
    this.x = x;
    this.y = y;
  }
  
  void setSize(float width, float height){ // 縦幅、横幅のsetter 
    this.width = width;
    this.height = height;
  }
  
  void setSpeed(float vx, float vy){ // y方向の速さ、x方向の速さのsetter 
    this.vx = vx;
    this.vy = vy;
  }
  
  void setColor(float r, float g, float b){ // rgbのsetter 
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  void setAccel(float ax, float ay){ // x方向の加速度、y方向の加速度のsetter 
    this.ax = ax;
    this.ay = ay;
  }
  
  Ball copy(){ // 全く同じプロパティを持つインスタンスを作成し、それを戻り値とする。
    Ball ball = new Ball();
    ball.setPoint(this.x, this.y);
    ball.setSpeed(this.vx, this.vy);
    ball.setSize(this.width, this.height);
    ball.setColor(this.r, this.g, this.b);
    ball.setAccel(this.ax, this.ay);
    return ball;
  } 

  void move() { // 花火の移動を担う。呼ばれるたびに移動する。(これだけでは描画はされない)
    this.addOrbit(this.copy());
    this.ax = (float) - (float)(air_resist_const * this.vx);
    this.ay = (float)gravity - (float)(air_resist_const * this.vy);
    this.vx += ax;
    this.vy += ay;
    this.x += vx;
    this.y += vy;
    
  }
  
  void drawOrbit(){ // orbitのdrawを行う。通常のdrawと違い、綺麗に尾を描くように、先頭ほどopacity値が低く、後方ほどopacity属性が高い
    for (int i = 0; i < this.orbit.size(); i++){
      orbit.get(i).opacity = this.opacity * i / this.orbit.size();  
      this.orbit.get(i).draw();
    }
  }

  void draw() { // 実際の描画処理
    this.setVisible(); // 速度が0に近づいたら、visibleをfalseに書き換える
    drawOrbit();
    if (visible){ // trueであれば、何もしない
     
    }
    else{ // falseであれば、destroy(背景色と同化させる)
         this.destroy();
    }
    
    fill(r, g, b, opacity); // 図形の塗りつぶし。直後に呼ばれた図形描画処理(ellipse, rectなど)に対して適用される。
    stroke(r, g, b, opacity);
    ellipse(x, y, width , height);
  }
  
  void setVisible(){ 
       // 速さが0に近づいた時に、this.visible = falseにする
       //if (-0.5 < this.vx && thisopacity.vx < 0.5 && -0.5 < this.vy  &&  this.vy < 0.5){
       //  this.visible = false;
       //}
       
       // 画面外に粒子が出たときに、this.visible = falseにする
       if ( this.y > 1000){
         this.visible = false;
       }
  }
  

  void destroy() { // red, green, blue全てに0を設定することで、見えなくする
    this.r = 0;
    this.b = 0;
    this.g = 0;
    
  }
}
