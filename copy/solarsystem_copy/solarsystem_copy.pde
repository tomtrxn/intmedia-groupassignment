import peasy.*;

Planet sun;
PeasyCam cam;

PImage sunTexture;
PImage[] textures = new PImage[3];


// Skybox
float angle;
PVector p;
PImage img;
PShape globe;

void setup() {
  fullScreen(P3D);
  angle=0;

  p = new PVector(1, 0, 1);

  noStroke();
  img = loadImage("blenderBG/bg_R1.png");
  globe = createShape(SPHERE, 3000);
  globe.setTexture(img);


  sunTexture = loadImage("data/building11.jpg");
  textures[0] = loadImage("planets/mars.jpg");
  textures[1] = loadImage("planets/earth.jpg");
  textures[2] = loadImage("planets/mercury.jpg");

  cam = new PeasyCam(this, 500);
  sun = new Planet(50, 0, 0, sunTexture);
  sun.spawnMoons(4, 1);
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
  
}
