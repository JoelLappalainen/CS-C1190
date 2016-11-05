import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;

JSONObject gdp, suicide, kuha;

void setup() { 
  
  size (1280, 940);
  kartta = loadShape("datmap.svg");
  
  gdp = new JSONObject();
  gdp = loadJSONObject("data/gdp.json");
  suicide = new JSONObject();
  suicide = loadJSONObject("data/suicide.json");
  kuha = new JSONObject();
  kuha = loadJSONObject("data/kuha.json");
  gdp();  
  suicide();
  kuha();
}


/*
Function for parsing JSON data from data folder to java. JSON files are generated with eurostat's
query builder and this function should work with every search result.
See: http://ec.europa.eu/eurostat/web/json-and-unicode-web-services/getting-started/query-builder)
*/
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
  //PShape ctry;
  
  int i = 0;
  while(i < labelKeys.size()){
    String code = labelKeys.get(i);
   // ctry = kartta.getChild(code.toLowerCase());
    String index = Integer.toString(indexes.getInt(code)); 
    String country = labels.getString(code);
    try {
      if(statusKeys.contains(index) && status.getString(index).equals(":")) {
        println("Country: " + country + "," + " value: Not available!");
      }
      else {
        long value = values.getLong(index);
       // ctry.setFill(color(random(255)));
        println("Country: " + country + "," + " value: " + value );     
      }
    } catch(Exception e) {
      println(e);
    }
    i += 1;
  }
}

void getKuha(JSONObject file) {
  JSONObject values = file.getJSONObject("value");
  JSONObject dimensions = file.getJSONObject("dimension");
  JSONObject geo = dimensions.getJSONObject("geo");
  JSONObject geoCategory = geo.getJSONObject("category");
  JSONObject geoIndexes = geoCategory.getJSONObject("index");
  JSONObject geoLabels = geoCategory.getJSONObject("label");
  List<String> geoLabelKeys = new ArrayList<String>(geoIndexes.keys());
  
  JSONObject time = dimensions.getJSONObject("time");
  JSONObject timeCategory = time.getJSONObject("category");
  JSONObject timeIndexes = timeCategory.getJSONObject("index");
  List<String> yearStrings = new ArrayList<String>(timeIndexes.keys());
  int nOfYears = timeIndexes.size();
  int y = 0;
  
  while(y < nOfYears){
    println("\nYear " + yearStrings.get(y));
    int i = 0;
    while(i < geoLabelKeys.size()){
      String code = geoLabelKeys.get(i);
      String index = Integer.toString(geoIndexes.getInt(code) * nOfYears + y); 
      String country = geoLabels.getString(code);
     
      long value = values.getLong(index);
      println("Country: " + country + "," + " value: " + value );     
  
      i++;
    }
  y++;  
  }  
}

// get gdp data
void gdp() {
  println("Gross domestic product at market prices: \n");
  getData(gdp);
  println("\n \n******************************************** \n");
}

// get suicide data
void suicide() {
  println("Crude death by suicide from age 15 to 19:\n");
  getData(suicide);
  println("\n \n******************************************** \n");
}

void kuha() {
  println("Weight of pike-perch caught in tonnes:"); 
  getKuha(kuha);
  println("\n \n******************************************** \n");
}