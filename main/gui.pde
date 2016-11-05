PShape kartta;
PShape maa;

float skaala = 2.1;

void gayColor(){
  int topDeath = 0;
  for (int i = 0; i < states.size() - 1; i++){
    if (deathCount[i] > topDeath){
      topDeath = deathCount[i];
    }
  }

  for (int i = 0; i < states.size() - 1; i++){
    if (deathCount[i] == topDeath){
      kartta.getChild(states.get(i)).setFill(color(360, 100, 100));
    }
    else if (i != 13){
      kartta.getChild(states.get(i)).setFill(color(360, 100, 100*(float(deathCount[i])/float(topDeath))));
    }
  }
}


void draw(){
  background(0);
  translate(0, -150);
  scale(skaala);
  shape(kartta, 0, 0);
}