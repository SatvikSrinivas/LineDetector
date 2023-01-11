
void loadDarkPixels() {
  darkPixels = new ArrayList<Pixel>();
  for (int i = 0; i < displayHeight; i++)
    for (int j = 0; j < displayWidth; j++)
      if (get(i, j) == black)
        darkPixels.add(new Pixel(i, j));
}

color green = color (0, 255, 0);

float interiorDarkPixelRatio(float sizeReductionFactor) {
  float boxWidth = r - l, boxHeight = d - u,
    interiorLeft = l + sizeReductionFactor * boxWidth,
    interiorRight = r - sizeReductionFactor * boxWidth,
    interiorUp = u + sizeReductionFactor * boxHeight,
    interiorDown = d - sizeReductionFactor * boxHeight;
  stroke(green);
  drawBox(interiorLeft, interiorRight, interiorUp, interiorDown);
  int interiorDarkPixelCount = 0;
  for (Pixel p : darkPixels)
    if (p.x > interiorLeft && p.x < interiorRight && p.y < interiorDown && p.y > interiorUp)
      interiorDarkPixelCount++;
  return (float)interiorDarkPixelCount / darkPixels.size();
}

boolean isZero() {
  return interiorDarkPixelRatio(0.2) < 0.1;
}
