

void fakeMap() {
  colorMode(RGB, 100, 100, 100);
  for (int i=0; i<48; i++){
    fkartta.getChild(codes[i]).setFill(color(i, 0, 0));
  }
}

void countryHover() {
  fakeMap();
  pushMatrix();
    translate(0, -150);
    scale(skaala);
    shape(fkartta, 0, 0);
  popMatrix();
  
  int index = ceil(red(get(mouseX, mouseY)));
  if (index < 48) {
    String hoveredCountry = codes[index];
    Integer hoveredValue;
    
    hoveredValue = getData(files[dataIndex]).get(hoveredCountry);
  }
}