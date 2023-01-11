
public boolean isContinuous(ArrayList<Pixel> darkPixels) {
  int x = darkPixels.get(0).x, y = darkPixels.get(0).y, tolerance_isContinuous = 50, outlierCount = 0;
  for (int i = 0; i < darkPixels.size(); i++) {
    if (abs(darkPixels.get(i).x - x) > tolerance_isContinuous || abs(darkPixels.get(i).y - y) > tolerance_isContinuous) {
      outlierCount++;
    }
    x = darkPixels.get(i).x;
    y = darkPixels.get(i).y;
  }
  println(outlierCount);
  println(darkPixels.size());
  println(100 * ((double)outlierCount / darkPixels.size())+"%");
  if ((double)outlierCount / darkPixels.size() > 0.5)
    return false;
  return true;
}
