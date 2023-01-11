
void setup () {
  background(255);
  size(800, 800);
  fill(0);
  stroke(0);
  strokeWeight(2.5);
  textSize(25);
  load();
}

void mousePressed() {
  draw = true;
  evaluate = false;
  if (refresh == true)
    refreshCounter = refreshThreshold + 1;
}

void mouseReleased() {
  draw = false;
  start = null;
  end = null;
  straightLineTest = true;
  if (straightLineTest)
    evaluate = true;
  refresh = true;
  evaluate();
}

void evaluate() {
  if (!evaluate)
    return;
  fill(0);
  boolean straight = straightLine();
  //text("isContinuous() : "+ isContinuous(darkPixels), 50, 250);
  if (straight)
    text("You drew a STRAIGHT line.", 50, 50);
  else
    text("You drew something else.", 50, 50);
  //text("avgSlope = " + avgSlope_display, 50, 100);
  //text("widthOfDarkPixelSample = " + widthOfDarkPixelSample, 50, 150);
  //text("backEndSlope = " + backEndSlope, 50, 200);
}

boolean draw = false, refresh = false, evaluate = false, straightLineTest = false;
float[] start, end;

int refreshCounter = 0, refreshThreshold = 50;

void draw () {
  //background(255);
  //draw1();
  //textSize(200);
  //text("Hi", mouseX,mouseY);
  drawUserInput();
  straightLineTest_draw();
  //showMouseCoordinates();
}

void straightLineTest_draw() {
  if (!straightLineTest)
    return;
  if (refresh)
    if (++refreshCounter > refreshThreshold) {
      refresh = false;
      refreshCounter = 0;
      background(255);
    }
  drawUserInput();
}

void drawUserInput() {
  if (draw) {
    if (start == null)
      start = new float[] {mouseX, mouseY};
    else if (end == null)
      end = new float[]{mouseX, mouseY};
    else {
      start = end;
      end = new float[] {mouseX, mouseY};
      stroke(0);
      line(start[0], start[1], end[0], end[1]);
    }
  }
}

float tolerance = 0.45, avgSlope_display = 0, backEndSlope = 0;
int widthOfDarkPixelSample = -1;
ArrayList<Pixel> darkPixels;

public boolean straightLine() {
  loadDarkPixels();

  //sanitize();

  //widthOfDarkPixelSample = darkPixels.get(darkPixels.size() - 1).x - darkPixels.get(0).x;
  //if (widthOfDarkPixelSample < 1)
  //  return false;

  float avgSlope = 0;
  int end = (int)(0.1 * darkPixels.size());
  for (int i = 0; i < end; i++)
    avgSlope += slope(darkPixels.get(i), darkPixels.get(i+(end / 2)));
  avgSlope /= end;
  avgSlope_display = avgSlope;

  backEndSlope = 0;
  for (int i = darkPixels.size() - 1; i > darkPixels.size() - end; i--)
    backEndSlope += slope(darkPixels.get(i), darkPixels.get(i-(end / 2)));
  backEndSlope /= end;

  if (abs(avgSlope) > 1.0 || avgSlope == Float.POSITIVE_INFINITY) {
    avgSlope = 0;
    for (int i = 0; i < end; i++)
      avgSlope += slopeInv(darkPixels.get(i), darkPixels.get(i+(end / 2)));
    avgSlope /= end;
    avgSlope_display = avgSlope;
    for (int i = 0; i < darkPixels.size() - 20; i++)
      if (abs(slopeInv(darkPixels.get(i), darkPixels.get(i+20)) - avgSlope) > tolerance)
        return false;
  } else {
    for (int i = 0; i < darkPixels.size() - 20; i++)
      if (abs(slope(darkPixels.get(i), darkPixels.get(i+20)) - avgSlope) > tolerance)
        return false;
  }
  return true;
}

float slope (Pixel p1, Pixel p2) {
  return ((float)p2.y - p1.y) / ((float)p2.x - p1.x);
}

float slopeInv (Pixel p1, Pixel p2) {
  return ((float)p2.x - p1.x) / ((float)p2.y - p1.y);
}

void showMouseCoordinates() {
  if (!debug)
    return;
  String mouseCoordinates_display = "("+mouseX + ", "+mouseY+")";
  float w = textWidth("(999,999) "), h = 50, x = 0.995 * width - w, y = 0.975 * height;
  fill(255);
  noStroke();
  rect(x, y - h, w, 1.25 * h);
  fill(0);
  textSize(50);
  text(mouseCoordinates_display, x, y);
}

boolean debug = false;
color white = color(255), black = color(0);

void sanitize() {
  int j = -1, sanitationOffset = 5;
  for (int i = 0; i < darkPixels.size(); i++)
  {
    j = darkPixels.get(i).y;
    if (get(i + sanitationOffset, j) == white && get(i - sanitationOffset, j) == white
      && get(i, j + sanitationOffset) == white && get(i, j - sanitationOffset) == white
      && get(i + sanitationOffset, j + sanitationOffset) == white && get(i + sanitationOffset, j - sanitationOffset) == white
      && get(i - sanitationOffset, j + sanitationOffset) == white && get(i - sanitationOffset, j - sanitationOffset) == white) {
      darkPixels.remove(i);
      set(i, j, white);
    }
  }
}
