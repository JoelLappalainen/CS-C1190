import java.util.ArrayList;

PFont font;
PShape kartta;
PShape maa;

float skaala = 2.1;

int boxSize = 400;
int boxWidth = 190;
int boxHeight = 30;
int boxhover = 1;
color boxColor = color(149, 226, 255);
String dataNow = "";

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
      text("CS-C1190 - Vuorovaikutustekniikan studio", 515, 130);
      textSize(30);
      textAlign(CENTER);
      text("Valitse tarkasteltava data", width/2, 200);
      
    popMatrix();
    
    // Test if the cursor is over the box
    if (boxhover == 1) {
      overBox1 = true;
    } else if (boxhover == 2){
      overBox2 = true;
    } else if (boxhover == 3){
      overBox3 = true;
    } else if (boxhover == 4){
      overBox4 = true;
    } else if (boxhover == 5){
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
        fill(boxColor);
        rect(width/2, by, boxSize, boxHeight);
        noFill();
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox2) {                         // hiiri 2. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        fill(boxColor);
        rect(width/2, by+50, boxSize, boxHeight);
        noFill();
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox3) {                         // hiiri 3. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        fill(boxColor);
        rect(width/2, by+100, boxSize, boxHeight);
        noFill();
        rect(width/2, by+150, boxSize, boxHeight);
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox4) {                         // hiiri 4. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        fill(boxColor);
        rect(width/2, by+150, boxSize, boxHeight);
        noFill();
        rect(width/2, by+200, boxSize, boxHeight);
      } else if (overBox5) {                         // hiiri 5. boxin päällä
        noFill();
        rect(width/2, by, boxSize, boxHeight);
        rect(width/2, by+50, boxSize, boxHeight);
        rect(width/2, by+100, boxSize, boxHeight);
        rect(width/2, by+150, boxSize, boxHeight);
        fill(boxColor);
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
  font = createFont("AvenirNextCondensed-Bold", 18);
  textFont(font);
  if (start) {
    startScreen();
  } else {
    background(360, 0, 40);
    pushMatrix();
      translate(0, -150);
      scale(skaala);
      shape(kartta, 0, 0);
    popMatrix();  
    pushMatrix();
      translate(0, 0);
      scale(skaala);
      fill(0, 0, 100);
      textAlign(LEFT);
      text(dataNow, 10, 25);
    popMatrix();
  }
}

void keyPressed()
{
  
  if(key == 'a') {
    start = true;
  }/* else if(key == 'y') {
    year = max(year-1, 0);
  } else if(key == 'u') {
    year++ ;
  }*/
  
  if (key == 'b'){
    if(boxhover < datataulukko.size()){
      boxhover += 1;
      if(boxhover == 2){
        overBox1 = false;
        overBox2 = true;
      } else if(boxhover == 3){
        overBox2 = false;
        overBox3 = true;
      } else if(boxhover == 4){
        overBox3 = false;
        overBox4 = true;
      } else if(boxhover == 5){
        overBox4 = false;
        overBox5 = true;
      } else if(boxhover == 1){
        overBox5 = false;
        overBox1 = true;
      } 
    } else {
      boxhover = 1;
      overBox5 = false;
      overBox1 = true;
    }
  }
    
    println(boxhover);
    if(boxhover == 1 && key == 'x') {
      start = false;
      dataNow = datataulukko.get(0);
      suicide();
    } else if (boxhover == 2 && key == 'x' && start) {
      start = false;
      dataNow = datataulukko.get(1);
      gdp();
    } else if (boxhover == 3 && key == 'x' && start){
      start = false;
      dataNow = datataulukko.get(2);
      fish();
    } else if (boxhover == 4 && key == 'x' && start){
      start = false;
      dataNow = datataulukko.get(3);
      noises();
    } else if (boxhover == 5 && key == 'x' && start){
      start = false;
      dataNow = datataulukko.get(4);
      internet();
    }
  }