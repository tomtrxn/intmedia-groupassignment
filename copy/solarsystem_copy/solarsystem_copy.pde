import peasy.*;
import processing.sound.*;
import ddf.minim.*;

Planet sun;
PeasyCam cam;

PImage sunTexture;
PImage[] textures = new PImage[3];


// Skybox
float angle;
PVector p;
PImage img;
PShape globe;

// Audio
Minim minim;
AudioPlayer goodStatusSound;
AudioPlayer warningStatusSound;
AudioPlayer emergencyStatusSound;

String[] statusOptions = {"Good", "Warning", "Emergency"};

int populationIndex = 0; // track the population

// try int or string for status input
String solarSystemStatus = "Good"; // initial status

void setup() {
  fullScreen(P3D);
  angle=0;

  p = new PVector(1, 0, 1);

  noStroke();
  img = loadImage("blenderBG/bg_R1.png");
  globe = createShape(SPHERE, 3000);
  globe.setTexture(img);

//images must be 1024/512 for it to render
  sunTexture = loadImage("images/building11.jpg");
  textures[0] = loadImage("planets/mars.jpg");
  textures[1] = loadImage("planets/earth.jpg");
  textures[2] = loadImage("planets/mercury.jpg");

  cam = new PeasyCam(this, 500);
  sun = new Planet(50, 0, 0, sunTexture);
  sun.spawnMoons(4, 1);


// initialize the audio here
minim = new Minim(this);
goodStatusSound = minim.loadFile("good_status.mp3");
warningStatusSound = minim.loadFile("warning_status.mp3");
emergencyStatusSound = minim.loadFile("emergency_status.mp3");

// base status is "good"
playGoodStatusSound();

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

  
  // Lighting stuff for the sun shine
  int z = 100;
  for (int i = 0; i<2; i++) {
    z = -z;
    pointLight(255, 255, 255, -100, -100, z);
    pointLight(255, 255, 255, 100, -100, z);
    pointLight(255, 255, 255, 100, 100, z);
    pointLight(255, 255, 255, -100, 100, z);
  }
  

  sun.show();
  sun.orbit();
 
  // Check and update the solar system status
  if (frameCount % 600 == 0) // change the framecount to population variable
  { 
    // status changes randomly between good, warning and emergency
    // add parameter so the changes happen according to population data
    //String[] statusOptions = {"Good", "Warning", "Emergency"};
    
    solarSystemStatus = statusOptions[newIndex];
    populationIndex = (populationIndex + 1) % statusOptions.length; // options cycle through
    
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
 
