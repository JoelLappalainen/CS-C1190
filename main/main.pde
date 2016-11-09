import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

JSONObject suicide, gdp, fish, noises, internet;
Map<String, Integer> suicideData, gdpData, fishData, noisesData, internetData;
int dataIndex = 0;
JSONObject[] files;

int nOfStats = 5;
int year = nOfStats-1;
boolean start = true;
float bx = 270.0;
float by = 265.0;

void setup() { 
  colorMode(HSB, 360, 100, 100);
  size (1280, 940);
  kartta = loadShape("datmap.svg");
  fkartta = loadShape("datmap.svg");
  
  suicide = loadJSONObject("data/suicide5.json");
  gdp = loadJSONObject("data/gdp5.json");
  fish = loadJSONObject("data/kuha.json");
  noises = loadJSONObject("data/noises5.json");
  internet = loadJSONObject("data/internet5.json");
  
  JSONObject[] data = { suicide, gdp, fish, noises, internet };
  files = data;
}

/*
Function for parsing JSON data from data folder to java. JSON files are generated with eurostat's
query builder and this function should work with every search result.
See: http://ec.europa.eu/eurostat/web/json-and-unicode-web-services/getting-started/query-builder)
*/


Map<String, Integer> getData(JSONObject file) {
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