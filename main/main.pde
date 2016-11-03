import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;

JSONObject gdp;
JSONObject suicide;

void setup() {
  
  gdp = new JSONObject();
  gdp = loadJSONObject("/Users/Joel/Ohjelmointi/CS-C1190/main/data/gdp.json");
  suicide = new JSONObject();
  suicide = loadJSONObject("/Users/Joel/Ohjelmointi/CS-C1190/main/data/suicide.json");
  gdp();  
  suicide();
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
  
  int i = 0;
  while(i < labelKeys.size()){
    String code = labelKeys.get(i);
    String index = Integer.toString(indexes.getInt(code)); 
    String country = labels.getString(code);
    try {
      if(statusKeys.contains(index) && status.getString(index).equals(":")) {
        println("Country: " + country + "," + " value: Not available!");
      }
      else {
        long value = values.getLong(index);
        println("Country: " + country + "," + " value: " + value );     
      }
    } catch(Exception e) {
      println(e);
    }
    i += 1;
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