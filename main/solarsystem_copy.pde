import peasy.*;
import java.util.HashMap;
import processing.sound.*;
import ddf.minim.*;

Planet sun;
PeasyCam cam;

PImage sunTexture;
PImage[] textures = new PImage[3];

//differentiation modifier for orbiting speeds
float scalingFactor = 2;

// Skybox
float angle;
PVector p;
PImage img;
PShape globe;

HashMap<Integer, Float> oxyData = new HashMap<Integer, Float>();
HashMap<Integer, Float> powerData = new HashMap<Integer, Float>();
HashMap<Integer, Float> popData = new HashMap<Integer, Float>();

int selectedDateIndex = 0;

// Audio
Minim minim;
AudioPlayer goodStatusSound;
AudioPlayer warningStatusSound;
AudioPlayer emergencyStatusSound;

String[] statusOptions = {"Good", "Warning", "Emergency"};

int populationIndex = 0; // track the population

// try int or string for status input
String solarSystemStatus = "Good"; // initial status

// background
int currentRow = 1; 
String currentDate = ""; 
String selectedDay;
boolean pressKey = false;
Table firstTable;
Table secondTable;
int index = 0;



void setup() {
  size(600, 600, P3D);
  angle=0;

  p = new PVector(1, 0, 1);

  noStroke();
  img = loadImage("blenderBG/navy02.png");
  globe = createShape(SPHERE, 3000);
  globe.setTexture(img);

  sunTexture = loadImage("images/building11.jpg");
  textures[0] = loadImage("images/oxy.jpg");
  textures[1] = loadImage("images/openday.jpeg");
  textures[2] = loadImage("images/spark.jpg");

  cam = new PeasyCam(this, 500);
  sun = new Planet(50, 0, 0, "B11", sunTexture);
  sun.spawnMoons(3, 1, new String[] {"Oxygen", "Population", "Electricity"}, textures);


 Table oxyTable = loadTable("data/oxydata.csv", "header");
  for (TableRow row : oxyTable.rows()) {
    int dayNumber = row.getInt(0);
    float value = row.getFloat(1);
    oxyData.put(dayNumber, value);
  }

  Table powerTable = loadTable("data/powerdata.csv", "header");
  for (TableRow row : powerTable.rows()) {
    int dayNumber = row.getInt(0);
    float value = row.getFloat(1);
    powerData.put(dayNumber, value);
  }

  Table popTable = loadTable("data/popdata.csv", "header");
  for (TableRow row : popTable.rows()) {
    int dayNumber = row.getInt(0);
    float value = row.getFloat(1);
    popData.put(dayNumber, value);
  }
 
/*
// initialize the audio here
minim = new Minim(this);
goodStatusSound = minim.loadFile("good_status.mp3");
warningStatusSound = minim.loadFile("warning_status.mp3");
emergencyStatusSound = minim.loadFile("emergency_status.mp3");

// base status is "good"
playGoodStatusSound();

}
*/

// backgorund
firstTable = loadTable ("Air Temperature.csv", "header");
}

void draw() {

  background(0);
  pushMatrix();
  float[] pos = cam.getPosition();
  translate(pos[0], pos[1], pos[2]);
  rotate(angle, p.x, p.y, p.z);
  shape(globe);
  angle+=0.0001;
  popMatrix();
  
  if (powerData.containsKey(selectedDateIndex)) {
  //float usage = powerData.get(selectedDateIndex);
  //float brightness = map(usage, 0, 2, 0, 255);



  
  // Lighting stuff for the sun shine
  int z = 100;
  for (int i = 0; i<1; i++) {
    z = -z;
    pointLight(255, 255, 255, -100, -100, z);
    pointLight(255, 255, 255, 100, -100, z);
    pointLight(255, 255, 255, 100, 100, z);
    pointLight(255, 255, 255, -100, 100, z);
  }
  
//pointLight(brightness, brightness, brightness, 0, 0, 0);
  } else {
    println("No data found for selected date index; " + selectedDateIndex);
    
  }
  sun.show();
  sun.orbit();
 
  
  /*
  // Check and update the solar system status
  if (frameCount % 600 == 0) // change the framecount to population variable
  { 
    // status changes randomly between good, warning and emergency
    // add parameter so the changes happen according to population data
    //String[] statusOptions = {"Good", "Warning", "Emergency"};
    
    //solarSystemStatus = statusOptions[populationIndex];
    //populationIndex = (populationIndex + 1) % statusOptions.length; // options cycle through
    
    // loop to play the corresponding audio files
    if (solarSystemStatus.equals("Good")) 
    {
      playGoodStatusSound();
    }
    else if (solarSystemStatus.equals("Warning"))
    {
      playWarningStatusSound();
    }
    else if (solarSystemStatus.equals("Emergency"))
    {
      playEmergencyStatusSound();
    }
  }
}
*/

// background
  if(pressKey){
  updateTable();
  }
  
  if(secondTable != null){
  if (index < secondTable.getRowCount()) {
    float temperature = secondTable.getFloat(index, 1);
    index++;
    //println("index:>>" + index + "____" + "temperature:>>"+ temperature);
    
    if (temperature >= 5.33) {
      img = loadImage("blenderBG/bg_00.png");
      globe.setTexture(img);
    } else if (temperature <= 5.32 && temperature >= 5) {
      img = loadImage("blenderBG/bg_01.png");
      globe.setTexture(img);
    } else if (temperature <= 4.99 && temperature >= 4.96) {
      img = loadImage("blenderBG/bg_02.png");
      globe.setTexture(img);
    } else if (temperature <= 4.95 && temperature >= 4.93) {
      img = loadImage("blenderBG/bg_03.png");
      globe.setTexture(img);
    } else if (temperature <= 4.92) {
      img = loadImage("blenderBG/bg_04.png");
      globe.setTexture(img);
    } 
  }
  }else{
    if (index < firstTable.getRowCount()) {
    float temperature = firstTable.getFloat(index, 1);
    index++;
    //println("index:>>" + index + "____" + "temperature:>>"+ temperature);
    
    if (temperature >= 5.33) {
      img = loadImage("blenderBG/navy00.png");
      globe.setTexture(img);
    } else if (temperature <= 5.32 && temperature >= 5) {
      img = loadImage("blenderBG/navy01.png");
      globe.setTexture(img);
    } else if (temperature <= 4.99 && temperature >= 4.96) {
      img = loadImage("blenderBG/navy03.png");
      globe.setTexture(img);
    } else if (temperature <= 4.95 && temperature >= 4.93) {
      img = loadImage("blenderBG/navy04.png");
      globe.setTexture(img);
    } else if (temperature <= 4.92) {
      img = loadImage("blenderBG/navy05.png");
      globe.setTexture(img);
    } 
  }
  }
}


void keyPressed() {
  if (key >= '1' && key <= '9') {
    selectedDateIndex = key - '1' + 1;
    selectedDay = "0" + key;
    index = 0;
  } else if (key == '0') {
    selectedDateIndex = 10;
    selectedDay = "10";
    index = 0;
  }
  pressKey=true;

  float oxyValue = oxyData.get(selectedDateIndex);
  float powerValue = powerData.get(selectedDateIndex);
  float popValue = popData.get(selectedDateIndex);
  sun.planets[0].updateOrbitSpeed(oxyValue, scalingFactor);
  sun.planets[1].updateSize(popValue);
  sun.planets[2].updateSize(powerValue);
}
/*
void playGoodStatusSound() 
{
  goodStatusSound.rewind();
  goodStatusSound.play();
}

 void playWarningStatusSound() 
{
  warningStatusSound.rewind();
  warningStatusSound.play();
}
  void playEmergencyStatusSound() 
{
  emergencyStatusSound.rewind();
  emergencyStatusSound.play();
}
*/

// backgournd 
void updateTable() {
    secondTable = new Table();
    for (String columnName : firstTable.getColumnTitles()) {
      secondTable.addColumn(columnName);
    }

    for (TableRow sourceRow : firstTable.rows()) {
      String date = sourceRow.getString("2023-09-01 13:25:02");
      String day = date.substring(8, 10); 

      
      if (day.equals(selectedDay)) {
        //println(int(day) + "____" + int(selectedDay));
        TableRow newRow = secondTable.addRow();

        
        for (String columnName : firstTable.getColumnTitles()) {
          newRow.setString(columnName, sourceRow.getString(columnName));
        }
      }
    }

    pressKey=false;
}
//for fresh commit
