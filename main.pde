import ddf.minim.*; //<>//
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.*;

Minim minim;
//static AudioPlayer player;


Fireworks fw;
int WINDOW_WIDTH = 1000;
int WINDOW_HEIGHT = 1000;

void setup() {
    minim = new Minim(this);
    //player = minim.loadFile("hanabisakuretu.mp3");
    
  
    size(1000, 1000);
    background(0, 0, 0);
    //player.play();
    //fw = new Fireworks();
    //fw.explode_point = random(0, 500); //  爆発地点を設定
    //fw.setOriginPointAndSize(random(0, 500), 500f, 10.0f, 10.0f);  // originのサイズと座標を設定
    //fw.setCircles(); //
}


ArrayList<Fireworks> fw_list = new ArrayList<Fireworks>(); // 花火のインスタンスが格納される。
Iterator<Fireworks> iterator = fw_list.iterator();
ArrayList<Integer> dead_fw_list_index = new ArrayList<Integer>(); // 死んだ花火のインデックスを格納する
float generate_probability = 1; // 一度のdraw処理の中で、花火が生み出される確率。出現頻度を変えたいときはここをいじる

 
//fw_list.add(fw);

void draw() {

  background(0, 0, 0); // 直前のフレームの削除
  
  //fw.play();
  //fw.explode();
  
 
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
  //println("死んだ花火のリスト");
  //println(dead_fw_list_index);
  for (int dead_fw_index : dead_fw_list_index){
    fw_list.remove(dead_fw_index);
    println(dead_fw_index);
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
    fw.explode_point = random(0, WINDOW_HEIGHT); //  爆発地点を設定
    fw.setOriginPointAndSize(random(0, WINDOW_WIDTH), WINDOW_HEIGHT, 10.0f, 10.0f);  // originのサイズと座標を設定
    fw.setCircles(); // 
    fw_list.add(fw);
  }
  

}
