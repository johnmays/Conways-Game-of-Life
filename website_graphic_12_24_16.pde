void setup() {
  size(400, 400);
  noStroke();
  textAlign(CENTER);
}

void draw() {
  //pmouse on top
  float x = pmouseX;
  float y = pmouseY;
  float ix = width - pmouseX; // Inverse X
  float iy = height - pmouseY; // Inverse Y
  noStroke();
  background(126);
    //white one
  fill(255, 150);
  ellipse(x, height/2, y, y);
    //dark one
  fill(0, 159);
  ellipse(ix, height/2, iy, iy);
  if(mousePressed){
    bottomLines();
    topLines();
    rightLines();
    leftLines();
  } else{
    text("[Hold mouse and drag.]",width / 2,height / 2);
  }
}
void bottomLines(){
  float x = pmouseX;
  float y = pmouseY;
  float ix = width - pmouseX; // Inverse X
  float iy = height - pmouseY; // Inverse Y
//lines for dark circle
  stroke(0, 159);
  line(width / 2, height,ix,height / 2 + iy / 2);
  line(width / 2, height,ix + iy / 2,height / 2);
  line(width / 2, height,ix - iy / 2,height / 2);
    //lines for light circle
  stroke(255,150);
  line(width / 2, height,x,height / 2 + y / 2);
  line(width / 2, height,x + y / 2,height / 2);
  line(width / 2, height,x - y / 2,height / 2);
}
void topLines(){
  float x = pmouseX;
  float y = pmouseY;
  float ix = width - pmouseX; // Inverse X
  float iy = height - pmouseY; // Inverse Y
//lines for dark circle
  stroke(0, 159);
  line(width / 2, 0,ix,height / 2 - iy / 2);
  line(width / 2, 0,ix + iy / 2,height / 2);
  line(width / 2, 0,ix - iy / 2,height / 2);
    //lines for light circle
  stroke(255,150);
  line(width / 2, 0,x,height / 2 - y / 2);
  line(width / 2, 0,x + y / 2,height / 2);
  line(width / 2, 0,x - y / 2,height / 2);
}
void rightLines(){
  float x = pmouseX;
  float y = pmouseY;
  float ix = width - pmouseX; // Inverse X
  float iy = height - pmouseY; // Inverse Y
//lines for dark circle
  stroke(0, 159);
  line(width, height / 2,ix,height / 2 + iy / 2);
  line(width, height / 2,ix + iy / 2,height / 2);
  line(width, height / 2,ix,height / 2 - iy / 2);
    //lines for light circle
  stroke(255,150);
  line(width, height / 2,x,height / 2 + y / 2);
  line(width, height / 2,x + y / 2,height / 2);
  line(width, height / 2,x,height / 2 - y / 2);
}
void leftLines(){
  float x = pmouseX;
  float y = pmouseY;
  float ix = width - pmouseX; // Inverse X
  float iy = height - pmouseY; // Inverse Y
//lines for dark circle
  stroke(0, 159);
  line(0, height / 2,ix,height / 2 + iy / 2);
  line(0, height / 2,ix - iy / 2,height / 2);
  line(0, height / 2,ix,height / 2 - iy / 2);
    //lines for light circle
  stroke(255,150);
  line(0, height / 2,x,height / 2 + y / 2);
  line(0, height / 2,x - y / 2,height / 2);
  line(0, height / 2,x,height / 2 - y / 2);
}