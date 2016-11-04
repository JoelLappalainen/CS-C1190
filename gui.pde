PShape kartta;
PShape maa;
float skaala = 2;

void setup(){
  size (1280, 940);
  kartta = loadShape("datmap.svg");
  maa = kartta.getChild("it");
  //maa.disableStyle();
}

void draw(){
  background(0);
  translate(-100, -100);
  scale(skaala);
  shape(kartta, 0, 0);
  //maa.disableStyle();
  fill(255);
}