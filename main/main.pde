import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

JSONObject gdp, suicide, fish, noises, internet;
Map gdpData, suicideData, fishData, noisesData, internetData;

boolean start;
float bx;
float by;

void setup() { 
  colorMode(HSB, 360, 100, 100);
  size (1280, 940);
  kartta = loadShape("datmap.svg");
  start = true;
  
  gdp = new JSONObject();
  gdp = loadJSONObject("data/gdp.json");
  suicide = new JSONObject();
  suicide = loadJSONObject("data/suicide.json");
  fish = new JSONObject();
  fish = loadJSONObject("data/kuha.json");
  noises = new JSONObject();
  noises = loadJSONObject("data/noises.json");
  internet = new JSONObject();
  internet = loadJSONObject("data/internet.json");
  //gdp();  
  //suicide();
  //fish();
  //noises();
  //internet();
  
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

void getData(JSONObject file) {
  JSONObject status = file.getJSONObject("status");
  List<String> statusKeys = new ArrayList<String>(status.keys());
  JSONObject values = file.getJSONObject("value");
  JSONObject dimensions = file.getJSONObject("dimension");
  JSONObject geo = dimensions.getJSONObject("geo");
  JSONObject category = geo.getJSONObject("category");
  JSONObject indexes = category.getJSONObject("index");
  JSONObject labels = category.getJSONObject("label");
  List<String> labelKeys = new ArrayList<String>(indexes.keys());
  
  int i = 0;
  while(i < labelKeys.size()){
    String code = labelKeys.get(i);
    if (file == suicide) states.add(code.toLowerCase());
    String index = Integer.toString(indexes.getInt(code)); 
    String country = labels.getString(code);
    try {
      if(statusKeys.contains(index) && status.getString(index).equals(":")) {
        println("Country: " + country + "," + " value: Not available!");
        if (file == suicide) deathCount[i] = 0;
      }
      else {
        int value = values.getInt(index);
        println("Country: " + country + "," + " value: " + value );  
        if (file == suicide) deathCount[i] = value;
      }
    } catch(Exception e) {
      println(e);
    }
    i += 1;
  }
}
*/

Map getData(JSONObject file, int year) {
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

Map getData(JSONObject file) {
  return getData(file, 0);
}


// get gdp data
void gdp() {
  println("Gross domestic product at market prices: \n");
  gdpData = getData(gdp);
  gayColor(gdpData, 1);
  println("\n \n******************************************** \n");
}

// get suicide data
void suicide() {
  println("Crude death by suicide from age 15 to 19:\n");
  suicideData = getData(suicide);
  gayColor(suicideData, 0);
  println("\n \n******************************************** \n");
}

void fish() {
  println("Weight of pike-perch caught in tonnes:"); 
  fishData = getData(fish);
  gayColor(fishData, 2);
  println("\n \n******************************************** \n");
}

void noises() {
  println("Noise from neighbours or from the street");
  noisesData = getData(noises);
  gayColor(noisesData, 3);
  println("\n \n******************************************** \n");
}

void internet() {
  println("Individuals - frequency of internet use");
  internetData = getData(internet);
  gayColor(internetData, 4);
  println("\n \n******************************************** \n");
}