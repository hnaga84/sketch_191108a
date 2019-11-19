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
