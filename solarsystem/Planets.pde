class Planet {
  float radius;
  float distance;
  Planet[] planets;
  float angle;
  float orbitspeed;
  String label;

  Planet(float r, float d, float o, String lbl) {
    radius = r;
    distance = d;
    angle = random(TWO_PI);
    orbitspeed = o;
    label =lbl;
    //println(angle);
  }

  void orbit() {
    angle = angle + orbitspeed;
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].orbit();
      }
    }
  }

  void spawnMoons(int total, int level) {
    planets = new Planet[total];
    for (int i = 0; i < planets.length; i++) {
      float r = radius/(level*2);
      float d = random(50, 150);
      float o = random(-0.01, 0.1);
      String[] labels = {"Oxygen", "Luminosity", "Electricity"}; 
      planets[i] = new Planet(r, d/level, o, labels[i]);
      if (level < 0) {
        int num = int(random(0,4));
        planets[i].spawnMoons(num, level+1);
      }
    }
  }

  void show() {
    pushMatrix();
    fill(255, 100);
    rotate(angle);
    translate(distance, 0);
    ellipse(0, 0, radius*2, radius*2);
    
    fill(255);
    text(label, 0, 0 - radius - 10);
    
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].show();
      }
    }
    popMatrix();
  }
}
