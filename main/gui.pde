import java.util.ArrayList;

PFont font;
PShape kartta;
PShape fkartta;
PShape maa;

float skaala = 2.1;

int boxSize = 400;
int boxWidth = 190;
int boxHeight = 30;
int boxhover = 1;
color boxColor = color(149, 226, 255);
String dataNow = "";
String[] maataulukko = { "al", "ad", "at", "by", "be", "ba", "bg", "hr", "cy", "cz", "dk", "ee",
                         "fo", "fi", "fr", "de", "il", "hu", "is", "ie", "im", "it", "rs", "lv",
                         "li", "lt", "lu", "mk", "mt", "md", "mc", "me", "nl", "no", "pl", "pt",
                         "ro", "ru", "sm", "rs", "sk", "si", "es", "se", "ch", "ua", "uk", "va"
                       };

boolean overBox1 = false;
boolean overBox2 = false;
boolean overBox3 = false;
boolean overBox4 = false;
boolean overBox5 = false;

ArrayList<String> datataulukko = new ArrayList<String>();

//0 itsarit, 1 gdp, 2 kuha, 3 meteli, 4 netti
void gayColor(Map<String,Integer> data, int coloriMoodi){
  kartta = loadShape("datmap.svg");
  int max = 0;
  int secondMax = 0;
  int min = 1000000000;
  int secondMin = 1000000000 + 1;
  Set<String> states = data.keySet();
  for (String state : states) {
    int current = data.get(state);
    if (current > max) {
      secondMax = max;
      max = current;
    }
    else if (current <= max && current >= secondMax) secondMax = current;
    if (current < min) {
      secondMin = min;
      min = current;
    }
    else if (current >= min && current <= secondMin) secondMin = current;
  }
  
  if (coloriMoodi == 1) {
    max = max - (max - secondMax) + 10000;
    min = min + (secondMin - min) - 10000;
  }
  else if (coloriMoodi == 2) max = max - (max - secondMax) + 100;
  else if (coloriMoodi == 4) min = min + (secondMin - min) - 1;
  println(max);
  println(secondMax);
  println(min);
  println(secondMin);
  for (String state : states){
    if (coloriMoodi == 0){
      kartta.getChild(state).setFill(color(360, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (coloriMoodi == 1){
      kartta.getChild(state).setFill(color(50, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (coloriMoodi == 2){
      kartta.getChild(state).setFill(color(141, 100, 100*(float(data.get(state) - min)/(float(max - min)))));
    }
    else if (coloriMoodi == 3){
      kartta.getChild(state).setFill(color(313, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (coloriMoodi == 4){
      kartta.getChild(state).setFill(color(208, 100, 100*(float(data.get(state) - min)/(float(max - min)))));
    }
  }
}

void startScreen(){    
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
  countryPicker();
  
  colorMode(HSB);
  background(360, 0, 40);
  pushMatrix();
    translate(0, -150);
    scale(skaala);
    shape(kartta, 0, 0);
  popMatrix();
  
  if (start) {
    startScreen();
  } else {
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
  }
  if(key == 'y') {
    year = year+1;
    if(currentData == 2) fish();
  } 
  if(key == 'u') {
    year = max(year-1,0);
    if(currentData == 2) fish();
  }
  if(key == 'e') {
    countryPicker();
  }
  
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

void countryPicker() {
  fakeMap();
  pushMatrix();
    translate(0, -150);
    scale(skaala);
    shape(fkartta, 0, 0);
  popMatrix();
  
  int index = ceil(red(get(mouseX, mouseY)));
  if (index < 48 && index > 10) {
    String hoveredCountry = maataulukko[index];
    Integer hoveredValue;
    
    if (currentData == 0) {
      hoveredValue = suicideData.get(hoveredCountry);
    } else if (currentData == 1) {
      hoveredValue = gdpData.get(hoveredCountry);
    } else if (currentData == 2) {
      hoveredValue = fishData.get(hoveredCountry);
    } else if (currentData == 3) {
      hoveredValue = noisesData.get(hoveredCountry);
    } else {
      hoveredValue = internetData.get(hoveredCountry);
    }
    println(hoveredValue);
  }
  
}