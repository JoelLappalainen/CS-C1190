int hoveredValue;

void fakeMap() {
  colorMode(RGB, 100, 100, 100);
  for (int i=0; i<48; i++){
    fkartta.getChild(allCodes[i]).setFill(color(i, 0, 0));
  }
}

void countryHover() {
  fakeMap();
  pushMatrix();
    translate(0, -150);
    scale(skaala);
    shape(fkartta, 0, 0);
  popMatrix();
  
  List<String> codeList = codes.get(dataIndex);
  
  int index = ceil(red(get(mouseX, mouseY)));
  if (index < 48) {
    String hoveredCountry = allCodes[dataIndex];
    if (codeList.contains(hoveredCountry)) {
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
      translate(mouseX, mouseY);
      scale(skaala);
      noFill();
      rectMode(CORNER);
      rect(0,0, 50, 50);
      String infoText;
      text(""+hoveredValue, 25, 25);
    popMatrix();
  }
}