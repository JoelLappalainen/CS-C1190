import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;

JSONObject gdp;
JSONObject suicide;

void setup() {
  
  gdp = new JSONObject();
  gdp = loadJSONObject("data.json");
  suicide = new JSONObject();
  suicide = loadJSONObject("suicide.json");
  gdp();  
  suicide();
}

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
    try {
        String index = Integer.toString(indexes.getInt(code));    
        long value = values.getLong(index);
        String country = labels.getString(code);
        println("Country: " + country + "," + " code: "+ code + "," + " value: " + value );      
    } catch(Exception e) {
      println(e);
    }
    i += 1;
  }
}

// get gdp data
void gdp() {
  getData(gdp);
}

// get suicide data
void suicide() {
  getData(suicide);
}