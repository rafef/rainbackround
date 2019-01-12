PImage photo;
PImage mist;
int cols,rows;
int scl = 5;
int w = 1280;
int h = 720;
float dead = 0;
float[][] terrain;
Drop[] raindrop = new Drop[900];
void setup(){
  frameRate(90);
  size(1280,720, P3D);
  background(150);
  photo = loadImage("moon_PNG52.png");
  mist = loadImage("Mist-PNG-Clipart.png");
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  
  for (int i = 0; i < raindrop.length; i++){
    raindrop[i] = new Drop();
  }
 // raindrop2 = new Drop(color(0,0,255),10,2,round(random(1,4)),random(0,500),0);
 // raindrop3 = new Drop(color(0,0,255),10,2,round(random(1,4)),random(0,500),0);
 // raindrop4 = new Drop(color(0,0,255),10,2,round(random(1,4)),random(0,500),0);
}
void draw(){
  dead -= 0.01;
  background(10);
  pushMatrix();
  translate(-60,0);
  image(photo,100,25);
  popMatrix();
  image(mist,0,-150);
  stroke(0);
  fill(100);
  float yoff = 0;
  for (int y = 0; y < rows; y++){
    float xoff = dead;
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoff,yoff),0,1,-30,30);
      xoff += 0.1;
    }
      yoff += 0.1;
  }
  for (int i = 0; i < raindrop.length; i++){
    raindrop[i].drive();
    raindrop[i].display();
  }
  translate(w/2,h/2);
  rotateX(PI/3);
  translate(-w/2,-h/2);
  noStroke();
  for (int y = 0; y < rows - 1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++ ){
      fill(25 + random(-2,50),25+ random(-2,50),25 + random(-2,50),60);
      vertex(x*scl, y*scl,terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      
    }
    endShape();
  }
  
}

class Drop {
  color c;
  float dropwidth;
  float dropheight;
  float xpos;
  float ypos;
  float yspeed;
    Drop(){
      noStroke();
      c = color(0,0,1, 90);
      dropwidth = 10;
      dropheight = 2;
      xpos = random(0,1280);
      ypos = 0;
      yspeed = random(1,4);
    }
    void display(){
      stroke(c);
      fill(c);
      rect(xpos,ypos,dropheight,dropwidth);
      
    }
    void drive(){
      if (ypos > 720){
        xpos = random(0,1280);
        ypos = 0;
        yspeed = round(random(1,4));
      }
      ypos = ypos + yspeed;
    }
}
void keyPressed() {
  rect(0,0,500,500);
  fill(255);
}