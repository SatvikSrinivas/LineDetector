
class Pixel {
  int x, y;

  public Pixel (int x, int y) {
    this.x = x;
    this.y = y;
  }

  public String toString() {
    return x+","+y;
  }

  public void draw() {
    set(x, y, black);
  }

  public void draw(int x_0, int y_0) {
    set(x_0+x, y_0+y, black);
  }
}
