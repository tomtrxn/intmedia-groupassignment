Table table;

void setup() {
  size(800, 400);
  table = loadTable("building11_temperature.csv", "header");
  noLoop();
}

void draw() {
  background(255);
  float barWidth = width / table.getRowCount();

  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    float temperature = row.getFloat(1); // Get the temperature from the second column
    
    // Map temperature to a color
    color pixelColor = mapTemperatureToColor(temperature);
    
    // Set the fill color
    fill(pixelColor);
    
    // Draw a rectangle representing temperature
    float barHeight = map(temperature, 19.0, 23.0, 0, height);
    rect(i * barWidth, height - barHeight, barWidth, barHeight);
  }
}

color mapTemperatureToColor(float temperature) {
  // Define a temperature range for color mapping (adjust as needed)
  float minTemp = 19.0;
  float maxTemp = 23.0;
  
  // Map temperature to a color gradient from bright red (high) to bright yellow (low)
  float mappedColorValue = map(temperature, minTemp, maxTemp, 0, 1);
  return lerpColor(color (255, 255, 0), color(255, 0, 0), mappedColorValue);
}
