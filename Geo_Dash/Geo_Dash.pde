import gifAnimation.*;

PVector vel = new PVector(0,0);
PVector pos = new PVector(0,0);
PVector acc = new PVector(0,0);

PVector coin1 = new PVector();
boolean got_c1, got_c2, got_c3;

boolean up = false;
PImage img;
int bgx, bgy;
int speed = 5;

int mode = 0;
int score = 0;
Gif animation;

boolean play = false;

void setup(){
  size(800,600);
  //reset();
  pos = new PVector(30,height-101);
  img = loadImage("platform32.png");
  animation = new Gif(this, "coin.gif");
  animation.play();
  coin1 = new PVector(4640,150);
  /*image(img,bgx,bgy);
  vel.x = 5;
  avatar();
  vel.add(acc);
  pos.add(vel);*/
}
void draw(){
  if(mode == 0){
    menuPage();
  }
  else if(mode == 1){
    play();
  }
  else if(mode == 2){
    losePage();
  }
  else if(mode == 3){
    winPage();
  }
}
void getPoint(){
  if(pos.x+30 == coin1.x && pos.y + 30 >= coin1.y && pos.y <= coin1.y+56){
    got_c1 = true;
    score+=1;
  }
  if(got_c1 == false){
    coin1.x -= speed;
    image(animation,coin1.x,coin1.y);
  }
}
void fall(){
  if(up == false){
    if(pos.y <= height-101){
      acc.y = 3;
    }
  }
}

void avatar(){
  noStroke();
  fill(0, 0, 255);
  square(pos.x,pos.y,30);
}

void collision(){
  loadPixels();
  int bottom = (int) ((pos.y+31)*width+pos.x);
  for(int i = 0; i < 30; i++){
    color c = pixels[bottom+i];
    color b = color(0);
    int threshold = 5;
    if(abs(red(c)-red(b)) < threshold && abs(green(c)-green(b)) < threshold && abs(blue(c)-blue(b)) < threshold){
      vel.y = 0;
      acc.y = 0;
      up = false;
    }
  }
}

void mouseClicked(){
  if((abs(mouseX-(width/2 - 5)) <= 75) && (abs(mouseY-(height/2 + 85)) <= 35)){
    mode = 1;
  }
}
void menuPage(){
  background(0);
  fill(255);
  text("GEO DASH",width/2-100,height/2);
  textSize(50);
  fill(color(0,0,255));
  rect(width/2-80,height/2+50,170,70);
  fill(255);
  text("PLAY",width/2-50,height/2+100);
}
void reset(){
  pos = new PVector(30,height-101);
  img = loadImage("platform32.png");
  animation = new Gif(this, "coin.gif");
  animation.play();
  coin1 = new PVector(4640,150);
}
void play(){
  image(img,bgx,bgy);
  avatar();
  vel.add(acc);
  pos.add(vel);
  //System.out.println(pos.x);
  // moving background and avatar
  if(pos.x <= 250){
    vel.x = 5;
    //System.out.println("test");
  }
  else{
    if(bgx-width == -7150){
      vel.x = 5;
      speed = 0;
      bgx = -7150+width;
    }
    else{
      bgx -= speed;
      vel.x = 0;
    }
  }

  if(pos.y >= height-101 && vel.y >= 0){
    pos.y = height-101;
    vel.y = 0;
    acc.y = 0;
    up = false;
  }
  if(pos.x == width){
    mode = 3;
  }
  
  collision();
  fall();
  die();
}
void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      if(up == false){
        vel.y = -30;
        acc.y = 3;
        up = true;
      }
    }
  }
}
void losePage(){
  background(0);
  fill(255);
  text("YOU LOST!",width/2-100,height/2);
  textSize(50);
  fill(color(0,0,255));
  rect(width/2-80,height/2+50,170,70);
  fill(255);
  text("REPLAY",width/2-75,height/2+100);
}
void winPage(){
  background(0);
  fill(255);
  text("YOU WIN!",width/2-100,height/2);
  textSize(50);
  fill(color(0,0,255));
  rect(width/2-80,height/2+50,170,70);
  fill(255);
  text("REPLAY",width/2-75,height/2+100);
}
void die(){
  loadPixels();
  for(int i = 0; i < 30; i++){
    int bottom = (int) ((pos.y+30)*width+pos.x);
    int right = (int) ((pos.y)*width+pos.x+30);
    color bottom_c = pixels[bottom+i];
    color right_c = pixels[right+i*width];
    color b = color(240,50,30);
    int threshold = 20;
    if(abs(red(bottom_c)-red(b)) <= threshold && abs(green(bottom_c)-green(b)) <= threshold && abs(blue(bottom_c)-blue(b)) <= threshold){
      vel.y = 0;
      acc.y = 0;
      up = false;
      mode = 2;
    }
    if(abs(red(right_c)-red(b)) < threshold && abs(green(right_c)-green(b)) < threshold && abs(blue(right_c)-blue(b)) < threshold){
      vel.y = 0;
      acc.y = 0;
      up = false;
      mode = 2;
    }
  }
}
