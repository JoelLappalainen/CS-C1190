import java.util.ArrayList;

PShape kartta;
PShape maa;

float skaala = 2.1;

int boxSize = 400;
int boxWidth = 190;
int boxHeight = 30;

boolean overBox1 = false;
boolean overBox2 = false;
boolean overBox3 = false;
boolean overBox4 = false;
boolean overBox5 = false;

ArrayList<String> datataulukko = new ArrayList<String>();

void gayColor(Map<String,Integer> data){
  kartta = loadShape("datmap.svg");
  int max = 0;
  Set<String> states = data.keySet();
  for (String state : states) {
    int current = data.get(state);
    if (current > max) max = current;
  }
  for (String state : states){
    kartta.getChild(state).setFill(color(360, 100, 100*(float(data.get(state))/float(max))));
  }
}

void startScreen(){
    background(360, 0, 40);
    
    pushMatrix();
      translate(0, -150);
      scale(skaala);
      shape(kartta, 0, 0);
    popMatrix();
    
    pushMatrix();
      translate(0, 0);
      rectMode(CORNER);
      fill(255, 0, 0, 191);
      rect(250, 100, 800, 550); //tumma boksi
      fill(0, 0, 100);
      textSize(14);
      textAlign(RIGHT);
      text("CS-C1190 - Vuorovaikutustekniikan studio", 570, 130);
      textSize(30);
      textAlign(CENTER);
      text("Valitse tarkasteltava data", width/2, 200);
      translate(0, 0);
      rectMode(CORNER);
      fill(255, 0, 0, 100);
      rect(0, 0, 1280, 940); //tumma taso kartan päällä
      fill(255, 0, 0, 191); 
      rect(250, 100, 800, 550); //tumma boksi
      fill(0, 0, 100);
      textSize(14);
      textAlign(RIGHT);
      text("CS-C1190 - Vuorovaikutustekniikan studio", 570, 130);
      textSize(30);
      textAlign(CENTER);
      text("Valitse tarkasteltava data", width/2, 200);
    popMatrix();
    
    // Test if the cursor is over the box
    if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by-boxHeight/2 && mouseY < by+boxHeight/2) {
      overBox1 = true;
    } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+50-boxHeight/2 && mouseY < by+50+boxHeight/2){
      overBox2 = true;
    } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+100-boxHeight/2 && mouseY < by+100+boxHeight/2){
      overBox3 = true;
    } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+150-boxHeight/2 && mouseY < by+150+boxHeight/2){
      overBox4 = true;
    } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+200-boxHeight/2 && mouseY < by+200+boxHeight/2){
      overBox5 = true;
    } else {
      overBox1 = false;
      overBox2 = false;
      overBox3 = false;
      overBox4 = false;
      overBox5 = false;
    }
     
      strokeWeight(0.5);
      stroke(0, 0, 100);
      textSize(15);
      textAlign(CENTER);
      rectMode(CENTER);
      
      if (overBox1) {                                // hiiri 1. boxin päällä
        fill(0, 100, 29);
        rect(width/2, by, boxSize, boxHeight);
        noFill();
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox2) {                         // hiiri 2. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        fill(0, 100, 29);
        rect(width/2, by+50, boxSize, boxHeight);
        noFill();
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox3) {                         // hiiri 3. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        fill(0, 100, 29);
        rect(width/2, by+100, boxSize, boxHeight);
        noFill();
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox4) {                         // hiiri 4. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        fill(0, 100, 29);
        rect(width/2, by+150, boxSize, boxHeight);
        noFill();
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox5) {                         // hiiri 5. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        fill(0, 100, 29);
        rect(width/2, by+200, boxSize, boxHeight);
        noFill();
      } else {                                       // hiiri ei minkään boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      }
      
      fill(0, 0, 100);
      text(datataulukko.get(0), width/2, 270);
      text(datataulukko.get(1), width/2, 320);
      text(datataulukko.get(2), width/2, 370);
      text(datataulukko.get(3), width/2, 420);
      text(datataulukko.get(4), width/2, 470);
}

void draw(){
  if (start) {
    startScreen();
  } else {
    background(360, 0, 40);
    pushMatrix();
      translate(0, -150);
      scale(skaala);
      shape(kartta, 0, 0);
    popMatrix();  
  }
}

void mousePressed() {
  if(mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by-boxHeight/2 && mouseY < by+boxHeight/2) {
    start = false;
    suicide();
  } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+50-boxHeight/2 && mouseY < by+50+boxHeight/2) {
    start = false;
    gdp();
  } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+100-boxHeight/2 && mouseY < by+100+boxHeight/2){
    start = false;
    fish(0);
  } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+150-boxHeight/2 && mouseY < by+150+boxHeight/2){
    start = false;
    noises();
  } else if (mouseX > width/2-boxSize/2 && mouseX < width/2+boxSize/2 && mouseY > by+200-boxHeight/2 && mouseY < by+200+boxHeight/2){
    start = false;
    internet();
  }
}

void keyPressed()
{
  if(key == 'a') {
    start = true;
  }
}