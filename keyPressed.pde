
void keyPressed() {
  switch (key) {
  case 'b':
    box();
    break;
  case 'c':
    drawChar('1');
    break;
  case 'd':
    //debug = !debug;
    draw1();
    break;
  case 'e':
    evaluate = true;
    break;
  case 'l':
    load();
    break;
  case 'm':
    match();
    break;
  case 'p':
    produceSVG('1', 1200);
    break;
  case 'r':
    background(255);
    break;
  case 's':
    straightLineTest = !straightLineTest;
  }
}
