
color red = color(255, 0, 0);
float l, r, u, d;
void box() {
  loadDarkPixels();
  float[] boxInfo = boxInfo();
  l = boxInfo[0];
  r = boxInfo[1];
  u = boxInfo[2];
  d = boxInfo[3];

  float interiorDarkPixelRatio = interiorDarkPixelRatio(0.2);
  String darkPixelInfo = ""+interiorDarkPixelRatio*100+"%";
  if (isZero())
    darkPixelInfo+= "  [0]";
  else
    darkPixelInfo+= "  [1]";
  fill(black);
  setTextSize(50);
  text(darkPixelInfo, 10, 1.5*textHeight());

  drawBox();
}

float[] boxInfo() {
  l = displayWidth;
  r = 0;
  u = displayWidth;
  d = 0;
  for (int i = 0; i < displayHeight; i++)
    for (int j = 0; j < displayWidth; j++)
      if (get(i, j) == black) {
        if (i < l)
          l = i;
        else if (i > r)
          r = i;
        if (j < u)
          u = j;
        else if (j > d)
          d = j;
      }
  return new float[] {l, r, u, d};
}

void drawBox() {
  stroke(red);
  drawBox(l - 10, r + 10, u - 10, d + 10);
}

void drawBox(float l, float r, float u, float d) {
  line(l, d, l, u);
  line(l, u, r, u);
  line(r, u, r, d);
  line(r, d, l, d);
}
