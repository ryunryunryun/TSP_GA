TravellingSalesmansProblem tsp;

void setup() {
  size(600, 400);
  
  tsp = new TravellingSalesmansProblem(2, 1);
}

void draw () {
  tsp.drawThis();  
}

void mouseReleased () {
  tsp.clickThis();
}