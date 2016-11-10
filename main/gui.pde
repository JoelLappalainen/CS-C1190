import java.util.ArrayList;

PFont mainFont;
PShape clearMap;
PShape map;
PShape newMap;
PShape countries;

float scaleFactor = 2.0;

int boxSize = 400;
int boxWidth = 190;
int boxHeight = 30;
color boxColor = color(149, 226, 255);
String[] allCodes= { "al", "ad", "at", "by", "be", "ba", "bg", "hr", "cy", "cz", "dk", "ee",
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
String[] units   = { "per 100000", "M€", "t", "% per capita", "% daily access of population" };
String[] years   = { "2011", "2012", "2013", "2014", "2015" };

color biggestHue;
int biggestValue;
int smallestValue;

boolean cameraMode = false;
int pointSize = 70;

//0 itsarit, 1 gdp, 2 kuha, 3 meteli, 4 netti
void colorize(Map<String,Integer> data, int colorScheme){
  colorMode(HSB, 360, 100, 100);
  map = loadShape("datmap.svg");
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
  
  biggestValue = max;
  smallestValue = min;
  
  if (colorScheme == 0) {
    biggestHue = 360;
  } else if (colorScheme == 1) {
    biggestHue = 50;
    max = max - (max - secondMax) + 10000;
    min = min + (secondMin - min) - 10000;
  } else if (colorScheme == 2) {
    biggestHue = 141;
    max = max - (max - secondMax) + 100;
  } else if (colorScheme == 3 ) {
    biggestHue = 313;
  } else if (colorScheme == 4) {
    biggestHue = 208;
    min = min + (secondMin - min) - 1;
  }

  for (String state : states){
    if (colorScheme == 0){
      map.getChild(state).setFill(color(360, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (colorScheme == 1){
      map.getChild(state).setFill(color( 50, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (colorScheme == 2){
      map.getChild(state).setFill(color(141, 100, 100*(float(data.get(state) - min)/(float(max - min)))));
    }
    else if (colorScheme == 3){
      map.getChild(state).setFill(color(313, 100, 100*(float(data.get(state) - min)/(float(max) - min))));
    }
    else if (colorScheme == 4){
      map.getChild(state).setFill(color(208, 100, 100*(float(data.get(state) - min)/(float(max - min)))));
    }
  }
}

void startScreen(){    
    pushMatrix();
      translate(0, -150);
      scale(scaleFactor);
      shape(clearMap, 0, 0);
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
  fill(0, 0, 100);
  float siirtyma = (float(1)/float(6)) * (float(biggestValue) - float(smallestValue));
  text(units[dataIndex], 9, 240);
  for (int i = 0; i < 7; i++) {
    fill(color(biggestHue, 100, 100-(100*i/7)));
    rect(7, 250+(30*i), 30, 30);
    fill(0, 0, 100);
    text(ceil(biggestValue - i*(siirtyma)), 40, 270+(i*30));
  }
}

// For calculating the most red pixel on camera and use it as the cursor
void useCamera() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    int redX = 0; // X-coordinate of the most red pixel
    int redY = 0; // Y-coordinate of the most red pixel
    float hueValue = 240; // Minimum hue/(red) value to be picked
    int index = 0;
        
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {       
        int pixelValue = video.pixels[index]; // Get the color stored in the pixel
        float pixelHue = hue(pixelValue);  // Get pixel's hue value
        if (pixelHue > hueValue) {
          hueValue = pixelHue;
          redY = y;
          redX = video.width - x - 1; // reversed
        }
        index++;
      }
    }
    if(cameraMode) {
      fill(255, 204, 0, 128);
      ellipse(redX, redY, pointSize, pointSize); 
    }
  }
}

void mapScreen() {    
  countryHover();
  pushMatrix();
    translate(0, -150);
    scale(scaleFactor);
    shape(map, 0, 0);      
    translate(0, 75);
    fill(0, 0, 100);
    stroke(0,0,0);
    textAlign(LEFT);
    text(headers[dataIndex], 10, 25);
    text(years[year], 10, 50);
  popMatrix();
  colorKey();
  useCamera(); 
}

void draw(){
  textFont(mainFont);  
  colorMode(HSB, 360, 100, 100);
  background(360, 0, 40);
    
  if (start) {
    startScreen();
    touchpad.draw();
  } else {
    //countryHover();
    pushMatrix();
      translate(0, -150);
      scale(scaleFactor);
      shape(map, 0, 0);      
      translate(0, 75);
      fill(0, 0, 100);
      stroke(0,0,0);
      textAlign(LEFT);
      text(headers[dataIndex], 10, 25);
      text(years[year], 10, 50);
    popMatrix();
    colorKey();
    
    if (video.available()) {
      video.read();
      video.loadPixels();
      int redX = 0; // X-coordinate of the most red pixel
      int redY = 0; // Y-coordinate of the most red pixel
      float hueValue = 240; // Minimum hue/(red) value to be picked
      int index = 0;
          
      for (int y = 0; y < video.height; y++) {
        for (int x = 0; x < video.width; x++) {       
          int pixelValue = video.pixels[index]; // Get the color stored in the pixel
          float pixelHue = hue(pixelValue);  // Get pixel's hue value
          if (pixelHue > hueValue) {
            hueValue = pixelHue;
            redY = y;
            redX = video.width - x - 1; // reversed
          }
          index++;
        }
      }
      if(cameraMode) {
        fill(255, 204, 0, 128);
        ellipse(redX, redY, pointSize, pointSize); 
      }
    }
    mapScreen();
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
    } else if (key == 'x' || keyCode == ENTER){
      start = false;
      colorize(getData(files[dataIndex]), dataIndex);
    }
  } else {
    if(key == 'b' || keyCode == BACKSPACE) {
      start = true;
    } else if ((key == 'y' || keyCode == LEFT)) {
      year = max(year-1,0);
      colorize(getData(files[dataIndex]), dataIndex);
    } else if ((key == 'u' || keyCode == RIGHT)) {
      year = min(year+1, 4);
      colorize(getData(files[dataIndex]), dataIndex);
    } else if(key == 'c') {
      cameraMode = !cameraMode;
    }
  }
}