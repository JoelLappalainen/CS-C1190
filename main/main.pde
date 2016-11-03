import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;


JSONObject json;

void setup() {
  
  json = new JSONObject();
  json = loadJSONObject("data.json");
  JSONObject status = json.getJSONObject("status");
  List<String> statusKeys = new ArrayList<String>(status.keys());
  println(statusKeys);
  JSONObject values = json.getJSONObject("value");
  JSONObject dimensions = json.getJSONObject("dimension");
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