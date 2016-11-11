/*
This program visualizes some chosen data from eurostat.com on a vecctor graphic map.
First the user chooses the desired data from the menu using the arrow keys and enter.
The user can return to the menu using backspace. The user can change the year of the
shown data with the left and right arrow keys. Pointing the cursor to a country on 
the map shows the country's name and value regarding the data shown. This program
can only be used with an Apple computer with a touchpad.
  This program can also be used with a PS3 controller, although the control need to
be configured to correspond the correct keys on the keyboard. Pressing the c key 
enables camera control, where one can control the cursor with a red object in the 
camera view. Bringing the cursor to the right upper corner brings the user back to
to the menu. One can also use the swipe gesture to browse the data to be shown.
*/

import com.alderstone.multitouch.mac.touchpad.*;
import com.alderstone.multitouch.mac.touchpad.tests.*;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Observer;
import java.util.Observable;
import processing.video.*;

Touchpad touchpad;
JSONObject suicide, gdp, fish, noises, internet;
Map<String, Integer> suicideData, gdpData, fishData, noisesData, internetData;
int dataIndex = 0;
JSONObject[] files;
Map<Integer,List<String>> codes = new HashMap<Integer, List<String>>();
Capture video;

int nOfStats = 5;
int year = 4;
boolean start = true;
float bx = 270.0;
float by = 265.0;

void setup() { 
  //defined the size and framerate for the project and defined variables for
  //the files used
  colorMode(HSB, 360, 100, 100);
  size (1280, 940);
  frameRate(120);
  
  if (System.getProperty("os.name").toLowerCase() == "mac");
    touchpad = new Touchpad(width,height);
  mainFont = createFont("AvenirNextCondensed-Bold", 18);
  map = loadShape("datmap.svg");
  newMap = loadShape("datmap.svg");
  clearMap = loadShape("datmap.svg");
  
  video = new Capture(this, width, height);
  video.start();
  
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
  codes.put(dataIndex, geoLabelKeys); 
  JSONObject timeIndexes = dimensions.getJSONObject("time").getJSONObject("category").getJSONObject("index");
  List<String> yearsAsString = new ArrayList<String>(timeIndexes.keys());
  
  Map<String,Integer> data = new HashMap<String,Integer>();
  
  int nOfYears = timeIndexes.size();
  if (year >= nOfYears) year = nOfYears - 1;
  if (year < 0) year = 0;
  
  int i = 0;
  while(i < geoLabelKeys.size()){
    String code = geoLabelKeys.get(i);
    String index = Integer.toString(geoIndexes.getInt(code) * nOfYears + year); 
    data.put(code.toLowerCase(), values.getInt(index));
    i++;     
  } 
  return data;
}