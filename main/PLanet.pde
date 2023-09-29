class Planet {
  float radius;
  float distance;
  Planet[] planets;
  float angle;
  float orbitspeed;
  String label;
  PVector v;

  PShape globe;

 
  Planet(float r, float d, float o, String lbl, PImage img) {
    v = PVector.random3D();
    
    radius = r;
    distance = d;
    v.mult(distance);
    angle = random(TWO_PI);
    orbitspeed = o;
    label =lbl;
    
    noStroke();
    noFill(); 
    globe = createShape(SPHERE, radius); 
    if (img != null) {
      globe.setTexture(img);
    }

  }

  void orbit() {
    angle = angle + orbitspeed;
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].orbit();
      }
    }
  }

  void spawnMoons(int total, int level, String[] labels, PImage[] textures) {
    planets = new Planet[total];
    
    if (level == 1) {
        labels = new String[]{"Oxygen", "Population", "Electricity"};
    }

    for (int i = 0; i < planets.length; i++) {
        float r = radius/(level*2);
        float d = random((radius + r), (radius+r)*2);
        float o = random(-0.04, 0.04);
        String lbl = (labels != null && i < labels.length) ? labels[i] : "";
        planets[i] = new Planet(r, d, o, lbl, textures[i % textures.length]);
        if (level < 2) {
            int num = int(random(0,3));
            planets[i].spawnMoons(num, level+1, new String[]{}, textures);
        }
    }
  }

void updateOrbitSpeed(float speed, float scalingFactor) {
  orbitspeed = speed * scalingFactor;
}

void updateSize(float newRadius) {
    radius = newRadius;
    globe = createShape(SPHERE, radius);  // Update the globe shape with the new radius
    globe.setTexture(img);
}

  void show() {
    pushMatrix();
    noStroke();
    PVector v2 = new PVector(1,0,1);
    PVector p = v.cross(v2);
    rotate(angle, p.x, p.y, p.z);
    stroke(255);
    //line(0,0,0, v.x, v.y, v.z);
  
    translate(v.x, v.y, v.z);
    noStroke(); 
    fill(255);
    shape(globe);
    //if(distance==0) {
      //pointLight(255, 255, 255, 0, 0, 0);
    //}
      
    //sphere(radius);     
  
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
