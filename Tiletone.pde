PImage seed;
PGraphics buffer;
PFont font;

Cell cell;

void setup() {

  // Basics
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100);
  //strokeWeight(2);

  // Load font and src image
  font = createFont("jbm.ttf", 128);
  seed = loadImage("flower_3.png");
  buffer = createGraphics(width, height);

  image(seed, 0, 0);
  drawBuffer();
  drawOutput();
}


void drawBuffer() {
  buffer.beginDraw();
  buffer.imageMode(CENTER);
  buffer.image(seed, width / 2, height / 2);
  buffer.endDraw();
}

void drawOutput() {
  int amount = 100;
  float cellWidth = (float) width / amount;
  float cellHeight = cellWidth;

  buffer.loadPixels();

  for (int x = 0; x < amount; x++) {
    for (int y = 0; y < amount; y++) {

      int pd = pixelWidth / width;
      int pxW = int(((cellWidth * x) + (cellWidth / 2)) * pd);
      int pxH = int(((cellHeight * y) + (cellHeight / 2)) * pd);

      int c = buffer.pixels[index(pxW, pxH, buffer)];
      float cb = brightness(c);
      float m = map(cb, 0, 100, 0, 21);

      cell = new Cell(int(cellWidth * x), int(cellHeight * y), cellWidth, cellHeight, m);
      cell.font = font;
      cell.displayCell();
    }
  }
}

// Quick hack: calling draw in order to use "saveFrame";
void draw() {
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("output/output-####.png");
  }
}


// Accessing px in the px array
int index(int x, int y, PImage target) {
  // Prevent "array out of bounds" error
  if (x < target.pixelWidth && y < target.pixelHeight) {
    return x + y * target.pixelWidth;
  } else {
    // Safe value
    return 0;
  }
}
