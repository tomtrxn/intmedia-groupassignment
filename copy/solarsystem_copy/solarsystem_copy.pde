import peasy.*;
import java.util.HashMap;

Planet sun;
PeasyCam cam;

PImage sunTexture;
PImage[] textures = new PImage[3];


// Skybox
float angle;
PVector p;
PImage img;
PShape globe;

HashMap<Integer, Float> powerUsage = new HashMap<Integer, Float>();
int selectedDateIndex = 0;

void setup() {
  fullScreen(P3D);
  angle=0;

  p = new PVector(1, 0, 1);

  noStroke();
  img = loadImage("blenderBG/bg_R1.png");
  globe = createShape(SPHERE, 3000);
  globe.setTexture(img);

  sunTexture = loadImage("images/building11.jpg");
  textures[0] = loadImage("images/oxy.jpg");
  textures[1] = loadImage("images/openday.jpeg");
  textures[2] = loadImage("images/spark.jpg");

  cam = new PeasyCam(this, 500);
  sun = new Planet(50, 0, 0, "B11", sunTexture);
  sun.spawnMoons(3, 1, new String[] {"Oxygen", "Population", "Electricity"}, textures);


Table table = loadTable("data/powerdata.csv", "header");
  for (TableRow row : table.rows()) {
    int dayNumber = row.getInt(0);  // Day number is in the first column
    float usage = row.getFloat(1);  // Power usage is in the second column
    powerUsage.put(dayNumber, usage);
  }
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
  
  float usage = powerUsage.get(selectedDateIndex);
  float brightness = map(usage, 0, 2, 0, 255);

  
  // Lighting stuff for the sun shine
  int z = 100;
  for (int i = 0; i<1; i++) {
    z = -z;
    pointLight(255, 255, 255, -100, -100, z);
    pointLight(255, 255, 255, 100, -100, z);
    pointLight(255, 255, 255, 100, 100, z);
    pointLight(255, 255, 255, -100, 100, z);
  }
  
pointLight(brightness, brightness, brightness, 0, 0, 0);

  sun.show();
  sun.orbit();
  
}

void keyPressed() {
  if (key >= '1' && key <= '9') {
    selectedDateIndex = key - '1' + 1;
  } else if (key == '0') {
    selectedDateIndex = 10;
  }
}
