class Cell {
  float w;
  float h;
  float m;
  int x;
  int y;

  color cBlack   = #000000;
  color cBlue    = #2e2ae2;
  color cPurple  = #9b2de2;
  color cOrange  = #eb6425;
  color cYellow  = #f7c325;
  color cGreen   = #27c55a;
  color cRed     = #e9381f;

  PFont font;

  Cell(int x, int y, float w, float h, float m) {
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.m = m;
  }

  void displayCell() {
    switch(int(m)) {
    case 0:  cellType1(1);     break;
    case 1:  cellType2(1);     break;
    case 2:  cellType4(0, 2);  break;
    case 3:  cellType4(1, 2);  break;
    case 4:  cellType4(2, 2);  break;
    case 5:  cellType4(3, 2);  break;
    case 6:  cellType4(4, 2);  break;
    case 7:  cellType4(5, 2);  break;
    case 8:  cellType4(1, 1);  break;
    case 9:  cellType4(2, 1);  break;
    case 10: cellType4(3, 1);  break;
    case 11: cellType4(4, 1);  break;
    case 12: cellType4(5, 1);  break;
    case 13: cellType2(2);     break;
    case 14: cellType2(3);     break;
    case 15: cellType3(1);     break;
    case 16: cellType3(2);     break;
    case 17: cellType3(3);     break;
    case 18: cellType3(4);     break;
    case 19: cellType3(5);     break;
    case 20: cellType3(6);     break;
    case 21: cellType1(2);     break;
    }
  }

  // Full color cell shape
  // variation 1: black, variation 2: red
  void cellType1(int variation) {
    stroke(variation == 2 ? cRed : cBlack);
    fill(variation == 2 ? cRed : cBlack);
    rect(x, y, w, h);
  }

  // Geometric type shape
  void cellType2(int variation) {
    noStroke();
    fill(cOrange);
    rect(x, y, w, h);

    switch (variation) {
    case 1:
      // Inside shape, vertically centered within the cell
      stroke(cBlack);
      fill(cBlack);
      rect(x, y + (h - h / 1.6) / 2, w, h / 1.6);
      break;
    case 2:
      fill(cBlack);
      rect(x + w / 2, y, w / 2, h / 2);
       rect(x, y + h / 2, w / 2, h / 2);
      break;
    case 3:
      fill(cBlack);
      rect(x + w / 2, y, w / 3, h / 2);
      rect(x + w / 2 - w / 3, y + h / 2, w / 3, h / 2);
      break;
    }
  }

  // Orange background with centered black square
  // Variation controls square size (1=smallest, 6=largest)
  void cellType3(int variation) {
    float divisor = 3.0 - (variation - 1) * 0.3;
    float squareW = w / divisor;
    
    stroke(cGreen);
    fill(cGreen);
    rect(x, y, w, h);
    fill(cBlack);
    rect(x + (w - squareW) / 2, y + (h - squareW) / 2, squareW, squareW);
    // ellipse(x + w / 2, y + h / 2, squareW, squareW);
  }

  // Colored background with centered black letter
  // variation 1: no letter, 2: A, 3: B, 4: C, 5: D
  // colorScheme 1: blue bg + black text, 2: black bg + blue text
  void cellType4(int variation, int colorScheme) {
    String[] letters = { "", "A", "T", "C", "G" };
    color bg   = colorScheme == 2 ? cPurple : cBlue;
    color text = colorScheme == 2 ? cYellow : cBlack;
    stroke(cBlack);
    fill(bg);
    rect(x, y, w, h);
    if (variation > 1) {
      fill(text);
      textFont(font);
      textAlign(CENTER, CENTER);
      textSize(w * 0.7);
      text(letters[variation - 1], x + w / 2, y + h / 2);
    }
  }
}
