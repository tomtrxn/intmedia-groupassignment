//still to do:
//integrate a background change somehow
//assign the correct images to their respective labelled planet


import peasy.*;

Planet sun;

PeasyCam cam;

PImage b11Texture;
PImage[] textures = new PImage[3];

void setup() {
  size(600, 600, P3D);
  b11Texture = loadImage("images/building11.jpg");
  textures[0] = loadImage("images/lights.jpg");
  textures[1] = loadImage("images/spark.jpg");
  textures[2] = loadImage("images/oxy.jpg");
  cam = new PeasyCam(this, 400);
  sun = new Planet(50, 0, 0, "B11", b11Texture);
  sun.spawnMoons(3, 1, new String[]{"Oxygen", "Luminosity", "Electricity"});
  

}

void draw() {
  background(0);
  lights();
  sun.show();
  sun.orbit();
}
