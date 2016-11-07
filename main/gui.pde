PShape kartta;
PShape maa;

float skaala = 2.1;

void gayColor(Map<String,Integer> data){
  int max = 0;
  Set<String> states = data.keySet();
  for (String state : states) {
    int current = data.get(state);
    if (current > max){
      max = current;
    }
  }

  for (String state : states){
    kartta.getChild(state).setFill(color(360, 100, 100*(float(data.get(state))/float(max))));
  }
}


void draw(){
  background(0);
  translate(0, -150);
  scale(skaala);
  shape(kartta, 0, 0);
}