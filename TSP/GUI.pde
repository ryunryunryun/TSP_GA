public class Graffic {
  Environment env;
  
  public Graffic (Environment env) {
    this.env = env;
  }
  
  public void drawMap() {
    background(255);
    for (int i = 0; i < env.pointList.size(); i++) {
      fill(0);
      strokeWeight(5);
      point(env.pointList.get(i).x, env.pointList.get(i).y);
    }
    
    env.mating(10);
    
    Individual top = env.players.get(0);
    
    for (int i = 0; i < top.gene.length; i++) {
      stroke(255, 0, 0);
      strokeWeight(1);
      
      line(env.pointList.get(top.gene[i]).x, 
        env.pointList.get(top.gene[i]).y,
        env.pointList.get(top.gene[(i + 1) % top.gene.length]).x, 
        env.pointList.get(top.gene[(i + 1) % top.gene.length]).y);
    }
    
    stroke(0);
    for (int i = 0; i < env.players.size(); i++) {
      String output = "";
      
      for (int j = 0; j < env.players.get(i).gene.length; j++) {
        output += env.players.get(i).gene[j] + " ";
        
        textSize(7);
        textAlign(CENTER, CENTER);
      
      }
      fill(100);
      text(output + "  " + env.players.get(i).distance, width / 2, height / env.players.size() * i + 10);
    }
    
    stroke(0);
    fill(100, 100);
    rect(20, 30, 160, 70);
    
    fill(100);
    
    textSize(15);
    fill(0);
    text("GENERATION:" + env.generation, 100, 50);
    text("SIZE:" + env.pointList.size(), 100, 80);
    
    textSize(10);
    textAlign(LEFT, LEFT);
    text("fps " + frameRate, 510, 370);
  }
  
}