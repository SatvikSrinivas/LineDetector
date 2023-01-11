
float textSize;
final float textHeightFactor = 0.625;

float textHeight() {
  return textHeightFactor * textSize;
}

float getSize(float textHeight) {
  return textHeight / textHeightFactor;
}

void setTextSize(float size) {
  textSize = size;
  textSize(textSize);
}

void drawChar(char c) {
  float[] boxInfo = boxInfo();
  println(boxInfo);
  float boxHeight = boxInfo[3] - boxInfo[2], boxWidth = boxInfo[1] - boxInfo[0];
  setTextSize(getSize(boxHeight));
  fill(green, 127);
  String text = ""+c;
  text(text, boxInfo[0], boxInfo[3]);
}

void produceSVG(char c, float textSize) {
  setTextSize(textSize);
  String text = ""+c;
  fill(0);
  text(text, -50, (height+textHeight())/2);
  generate();
}

PrintWriter output;
void generate() {
  output = createWriter("1.txt");
  loadPixels();
  for (int i = 0; i < width; i++)
    for (int j = 0; j < height; j++) {
      if (get(i, j) == black) {
        //output.println(x + displayWidth/2.0 + "," + (-y + displayHeight/2.0));
        output.println(i + "," + j);
      }
    }
  output.close();
}

ArrayList<Pixel> data1;
void load() {
  data1 = new ArrayList<Pixel>();
  String[] lines = loadStrings("1.txt"), data;
  for (String l : lines) {
    data = l.split(",");
    data1.add(new Pixel(Integer.parseInt(data[0]), Integer.parseInt(data[1])));
  }
}

void draw1() {
  for (Pixel p : data1)
    p.draw(mouseX, mouseY);
}

void match() {
}
