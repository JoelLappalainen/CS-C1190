import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

JSONObject suicide, gdp, fish, noises, internet;
Map<String, Integer> suicideData, gdpData, fishData, noisesData, internetData;
int year;
int currentData;

boolean start;
float bx;
float by;

void setup() { 
  colorMode(HSB, 360, 100, 100);
  size (1280, 940);
  kartta = loadShape("datmap.svg");
  fkartta = loadShape("datmap.svg");
  start = true;
  year = 0;
  
  suicide = new JSONObject();
  suicide = loadJSONObject("data/suicide.json");
  suicideData = getData(suicide);
  gdp = new JSONObject();
  gdp = loadJSONObject("data/gdp.json");
  gdpData = getData(gdp);
  fish = new JSONObject();
  fish = loadJSONObject("data/kuha.json");
  fishData = getData(fish);
  noises = new JSONObject();
  noises = loadJSONObject("data/noises.json");
  noisesData = getData(noises);
  internet = new JSONObject();
  internet = loadJSONObject("data/internet.json");
  internetData = getData(internet);
  
  datataulukko.add("Crude death by suicide from age 15 to 19");
  datataulukko.add("Gross domestic product at market prices");
  datataulukko.add("Weight of pike-perch caught in tonnes");
  datataulukko.add("Noise from neighbours or from the street");
  datataulukko.add("Individuals - frequency of internet use");
  
  bx = 270.0;
  by = 265.0;
}

/*
Function for parsing JSON data from data folder to java. JSON files are generated with eurostat's
query builder and this function should work with every search result.
See: http://ec.europa.eu/eurostat/web/json-and-unicode-web-services/getting-started/query-builder)
*/


Map getData(JSONObject file) {
  JSONObject values = file.getJSONObject("value");
  JSONObject dimensions = file.getJSONObject("dimension");
  JSONObject geoCategory = dimensions.getJSONObject("geo").getJSONObject("category");
  JSONObject geoIndexes = geoCategory.getJSONObject("index");
  JSONObject geoLabels = geoCategory.getJSONObject("label");
  List<String> geoLabelKeys = new ArrayList<String>(geoIndexes.keys());
  JSONObject timeIndexes = dimensions.getJSONObject("time").getJSONObject("category").getJSONObject("index");
  List<String> yearsAsString = new ArrayList<String>(timeIndexes.keys());
  
  Map<String,Integer> data = new HashMap<String,Integer>();
  
  int nOfYears = timeIndexes.size();
  if (year >= nOfYears) year = nOfYears - 1;
  if (year < 0) year = 0;
  println("\nYear " + yearsAsString.get(year));
  int i = 0;
  while(i < geoLabelKeys.size()){
    String code = geoLabelKeys.get(i);
    String index = Integer.toString(geoIndexes.getInt(code) * nOfYears + year); 
    String country = geoLabels.getString(code);
    int value = values.getInt(index);
      
    data.put(code.toLowerCase(), values.getInt(index));
     
    println("Country: " + country + "," + " value: " + value );     
  
    i++;
  } 
  return data;
}

// get suicide data
void suicide() {
  println("Crude death by suicide from age 15 to 19:\n");
  currentData = 0;
  gayColor(suicideData, 0);
  println("\n \n******************************************** \n");
}

// get gdp data
void gdp() {
  println("Gross domestic product at market prices: \n");
  currentData = 1;
  gayColor(gdpData, 1);
  println("\n \n******************************************** \n");
}

void fish() {
  println("Weight of pike-perch caught in tonnes:");  
  currentData = 2;
  gayColor(fishData, 2);
  println("\n \n******************************************** \n");
}

void noises() {
  println("Noise from neighbours or from the street");
  currentData = 3;
  gayColor(noisesData, 3);
  println("\n \n******************************************** \n");
}

void internet() {
  println("Individuals - frequency of internet use");
  currentData = 4;
  gayColor(internetData, 4);
  println("\n \n******************************************** \n");
}