import java.util.ArrayList;

PFont font;
PShape kartta;
PShape fkartta;
PShape maa;

float skaala = 2.0;

int boxSize = 400;
int boxWidth = 190;
int boxHeight = 30;
color boxColor = color(149, 226, 255);
String[] codes   = { "al", "ad", "at", "by", "be", "ba", "bg", "hr", "cy", "cz", "dk", "ee",
                     "fo", "fi", "fr", "de", "el", "hu", "is", "ie", "im", "it", "rs", "lv",
                     "li", "lt", "lu", "mk", "mt", "md", "mc", "me", "nl", "no", "pl", "pt",
                     "ro", "ru", "sm", "rs", "sk", "si", "es", "se", "ch", "ua", "uk", "va"
                   };
String[] headers = { "Crude death by suicide from age 15 to 19",
                     "Gross domestic product at market prices",
                     "Weight of pike-perch caught in tonnes",
                     "Noise from neighbours or from the street",
                     "Individuals - frequency of internet use"
                   };
color isoinHue;
int isoinArvo;
int pieninArvo;
String yksikko;

//0 itsarit, 1 gdp, 2 kuha, 3 meteli, 4 netti
void gayColor(Map<String,Integer> data, int coloriMoodi){
  colorMode(HSB, 360, 100, 100);
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
    } else if (current <= max && current >= secondMax) {
      secondMax = current;
    } else if (current < min) {
      secondMin = min;
      min = current;
    } else if (current >= min && current <= secondMin) {
      secondMin = current;
    }
  }
  
  isoinArvo = max;
  pieninArvo = min;
  
  if (coloriMoodi == 0) {
    isoinHue = 360;
    yksikko = "per 100000";
  } else if (coloriMoodi == 1) {
    isoinHue = 50;
    max = max - (max - secondMax) + 10000;
    min = min + (secondMin - min) - 10000;
    yksikko = "M€";
  } else if (coloriMoodi == 2) {
    isoinHue = 141;
    max = max - (max - secondMax) + 100;
    yksikko = "t";
  } else if (coloriMoodi == 3 ) {
    isoinHue = 313;
    yksikko = "% per capita";
  } else if (coloriMoodi == 4) {
    isoinHue = 208;
    min = min + (secondMin - min) - 1;
    yksikko = "% daily access of population";
  }

  for (String state : states){
    if (coloriMoodi == 0){
      kartta.getChild(state).setFill(color(360, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (coloriMoodi == 1){
      kartta.getChild(state).setFill(color( 50, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
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
    kartta = loadShape("datmap.svg");
    
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
     
    strokeWeight(0.5);
    stroke(0, 0, 100);
    textSize(15);
    textAlign(CENTER);
    rectMode(CENTER);
    
    for(int i=0; i<nOfStats; i++){                       // piirretään valikko ja kirjoitetaan tekstit
      if(i == dataIndex) fill(boxColor); else noFill();
      rect(width/2, by+(i*50), boxSize, boxHeight);
      fill(0, 0, 100);
      text(headers[i], width/2, 270+(50*i));
    }
}

void colorKey() {
  colorMode(HSB, 360, 100, 100);
  rectMode(CORNER);
  stroke(1);
  float siirtyma = (float(1)/float(6)) * (float(isoinArvo) - float(pieninArvo));
  text(yksikko, 9, 240);
  for (int i = 0; i < 7; i++) {
    fill(color(isoinHue, 100, 100-(100*i/7)));
    rect(7, 250+(30*i), 30, 30);
    fill(0, 0, 100);
    text(ceil(isoinArvo - i*(siirtyma)), 40, 270+(i*30));
  }
}

void draw(){
  font = createFont("AvenirNextCondensed-Bold", 18);
  textFont(font);
  countryHover();
  
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
      text(headers[dataIndex], 10, 25);
    popMatrix();
    
    colorKey();
  }
}

void keyPressed() {
  if(start) {
    if (keyCode == DOWN){
      dataIndex++;
      if (dataIndex >= nOfStats) dataIndex = 0;
    } else if (keyCode == UP){
      dataIndex--;
      if (dataIndex < 0) dataIndex = nOfStats-1;
    } else if (key == 'x'){
      start = false;
      gayColor(getData(files[dataIndex]), dataIndex);
    }
  } else {
    if(key == 'b') {
      start = true;
    } else if ((key == 'y' || keyCode == LEFT)) {
      year = max(year-1,0);
      gayColor(getData(files[dataIndex]), dataIndex);
    } else if ((key == 'u' || keyCode == RIGHT)) {
      year++;
      gayColor(getData(files[dataIndex]), dataIndex);
    }
  }
}