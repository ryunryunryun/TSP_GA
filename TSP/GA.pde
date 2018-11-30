public class TravellingSalesmansProblem {
  Environment env;
  Graffic g;
  
  public TravellingSalesmansProblem (int cityNum, float probability) {
    env = new Environment(cityNum, probability);
    g= new Graffic(env);
  }
  
  
  public void drawThis () {
    g.drawMap();
  }
  
  public void clickThis () {
    env.addCity(mouseX, mouseY);
  }
}