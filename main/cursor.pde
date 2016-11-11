int hoveredValue;
String hoveredCountry;

void fakeMap() {
  colorMode(RGB, 100, 100, 100);
  background(80,0,0);
  for (int i=0; i<48; i++){
    newMap.getChild(allCodes[i]).setFill(color(i, 0, 0));
  }
}

void countryHover() {
  fakeMap();
  pushMatrix();
    translate(0, -150);
    scale(scaleFactor);
    shape(newMap, 0, 0);
  popMatrix();
  
  List<String> codeList = codes.get(dataIndex);    
  int index = ceil(red(get(cursorX, cursorY)));
  if (index < 48) {
    hoveredCountry = allCodes[index];
    if (codeList.contains(hoveredCountry.toUpperCase())) {
      hoveredValue = getData(files[dataIndex]).get(hoveredCountry);
    } else {
      hoveredValue = -1;
    }
  } else {
    hoveredValue = -1;
  }
  colorMode(HSB, 360, 100, 100);
}

void infoWindow() { 
  if (hoveredValue >= 0) {
    pushMatrix();
      translate(cursorX, cursorY);
      scale(scaleFactor);
      fill(255, 0, 0);
      stroke(100);
      text(hoveredCountry.toUpperCase() + " - " + hoveredValue, 10, 0);
    popMatrix();
  }
}