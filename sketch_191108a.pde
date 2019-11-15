class Ball {
  float x, y;
  float width, height;
  float vx, vy;
  float col;
  float r, g, b;
  float ax, ay;
  boolean visible;
  boolean enableGravity;

  Ball() {
    this.r = 150;
    this.b = 150;
    this.g = 150;
    this.visible = true;
  }

  void move() { // 花火の移動を担う。呼ばれるたびに移動する。
    this.x += vx;
    this.y += vy;
    this.vx += ax;
    this.vy += ay;
  }

  void draw() {
    this.setVisible();
    if (visible){
      
    }
    else{
         this.destroy();
    }
    //if (-1.0 <= this.vx  && this.vx <= 1.0 && 1.0 <=  this.vy && this.vy <= 1.0){
    //  fill(0);
    //}
    fill(r, g, b);
    ellipse(x, y, width , height);
  }
  
  void setVisible(){
       if (-0.5 < this.vx && this.vx < 0.5 && -0.5 < this.vy  &&  this.vy < 0.5){
         this.visible = false;
       }
  }
  
  

  void setSize(float x, float y, float width, float height) { // Ballの座標、幅、高さ
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  void destroy() {
    this.r = 0;
    this.b = 0;
    this.g = 0;
    
  }
}

class Circle {
  float accel;
  int balls_num;
  ArrayList<Ball> balls;
  float speed;
  float explode_point_x;
  float explode_point_y;
  float r,g,b;

  Circle() {
    this.balls_num = 8;
    initBalls();
  }

  void initBalls() {
    this.balls = new ArrayList<Ball>();
    //print("hogeghoegieg;sg;ish;gio");
    for (int i = 0; i < this.balls_num; i++) {
      this.balls.add(new Ball());
    }
  }

  void setBalls() {
    print("the size is " + this.balls.size());
    for (int i = 0; i < this.balls.size(); i++){ 
      print("--------------------------");
      balls.get(i).x = this.explode_point_x;
      balls.get(i).y = this.explode_point_y;
      balls.get(i).height = 5;
      balls.get(i).width = 5;
      balls.get(i).r = this.r;
      balls.get(i).g = this.g;
      balls.get(i).b = this.b;
      println((float)i / 8);
      balls.get(i).vx = this.speed*cos(((float)i/this.balls.size())*3.14*2);
      balls.get(i).vy = this.speed*sin(((float)i/this.balls.size())*3.14*2);
      balls.get(i).ax = this.accel*cos(((float)i/this.balls.size())*3.14*2);
      balls.get(i).ay = this.accel*sin(((float)i/this.balls.size())*3.14*2);
    }
    
  }

  void setExplodePoint(float explode_point_x, float explode_point_y) {
    this.explode_point_x = explode_point_x;
    this.explode_point_y = explode_point_y;
  }

  void setSpeed(float speed) {
    this.speed = speed;
  }

  void setAccel(float accel) {
    this.accel = accel;
  }



  void draw() {
    //this.balls = new ArrayList<Ball>();
    //balls.add(new Ball());
    //balls.get(0).x = this.explode_point_x;
    //balls.get(0).y = this.explode_point_y;
    //balls.get(0).height = 10;
    //balls.get(0).width = 10;
    //balls.get(0).vx = this.speed*cos(0/this.balls.size()*3.14);
    //balls.get(0).vy = this.speed*sin(0/this.balls.size()*3.14);
    //balls.get(0).ax = this.accel*cos(0/this.balls.size()*3.14);
    //balls.get(0).ay = this.accel*sin(0/this.balls.size()*3.14);
    for (int i = 0; i < this.balls.size(); i++) {
      //println(str(i) + str(balls.get(i).vx));
      balls.get(i).move();
      balls.get(i).draw();
    }
  }
}

class Fireworks {
  Ball origin;
  float r,g,b;
  int circle_num = 5;
  float explode_point;
  Circle[] circles;

  Fireworks() {
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
  
  void initCircles(){
    this.circles = new Circle[this.circle_num];
    for (int i = 0; i < this.circles.length; i++){
      circles[i] = new Circle();
    }
  }

  void setCircles() { // 各サークルの加速度を定義する
    for (int i = 0; i < this.circles.length; i++) {
      float accel = (i * -0.1);
      this.circles[i].setSpeed(10);
      this.circles[i].setAccel(accel);
      this.circles[i].setExplodePoint(this.origin.x, this.explode_point);
      this.circles[i].r = this.origin.r;
      this.circles[i].g = this.origin.g;
      this.circles[i].b = this.origin.b;
      this.circles[i] .setBalls();
    }
  }

  void setOrigin(float x, float y, float width, float height) { // 花火の元となるBallの各設定を定義する。
    this.origin.setSize(x, y, width, height);
  }

  void play() { // 花火の一生を担う
    origin.move();
    if (this.origin.y > explode_point) {
      origin.draw();
    } else if (this.origin.y == explode_point) {
      origin.draw();
    } else {
      this.explode();
    }
  }

  void explode() {
    for (int i = 0; i < this.circles.length; i++) {
      this.circles[i].draw();
    }
  }
}




Fireworks fw = new Fireworks();
Fireworks fw2 = new Fireworks();
Circle circle = new Circle();
Ball ball = new Ball();

void setup() {
    size(500, 500);

  // // to test fireworks
  fw.explode_point = random(0, 500);
  fw.setOrigin(random(0, 500), 500f, 10.0f, 10.0f); 
  fw.setCircles();
  //size(500, 500);
  //background(0, 0, 0);

  fw2.explode_point = 100;
  fw2.setOrigin(20.0f, 500f, 10.0f, 10.0f);
  fw2.setCircles();

  // // to test of circle
  //circle = new Circle();
  //circle.setExplodePoint(250, 250);
  //print(circle.explode_point_x);
  //circle.setSpeed(10);
  //circle.setAccel(-0.1);
  //circle.setBalls();
  //print(circle.explode_point_x);
  //print(circle.explode_point_y);

  // to test of ball
  //ball.x = 100;
  //ball.y = 100;
  //ball.width = 100;
  //ball.height = 100;
  //ball.vx = 1;
  //ball.vy = 0;
  //ball.ax = -0.1;
  //ball.ay = 0;
}

//void circleTester() {
//  circle.draw();
//}


ArrayList<Fireworks> fw_list = new ArrayList<Fireworks>();

void draw() {

  background(0, 0, 0);
  //ellipse(10, 10, 10, 10);

  //fw.play(); 
  //fw2.play();
  //circleTester();
  //print(circle.balls.get(0).x);
  //circle.balls.get(0).move();
  //print(circle.balls.get(0).vx);
  //print(circle.balls.get(0).vy);
  //print(circle.explode_point_x);
  //print(circle.explode_point_y);
  
  if (fw_list.size() == 0){
      
  }
  else{
      for (int i = 0; i < fw_list.size(); i++){
        fw_list.get(i).play(); 
      }
  }
  float num  = random(0, 250);
  if (num < 10){
    Fireworks fw = new Fireworks();
    fw.explode_point = random(0, 500);
    fw.setOrigin(random(0, 500), 500f, 10.0f, 10.0f); 
    fw.setCircles();
    fw_list.add(fw);
  }

}
