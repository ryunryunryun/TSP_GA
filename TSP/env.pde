public class Environment {
  ArrayList<PVector> pointList;
  int generation = 1;
  int maxPlayer = 30;
  ArrayList<Individual> players;
  
  float p; // mutation probability
  
  // add #point number of points to a list
  public Environment (int point, float p) {
    pointList = new ArrayList<PVector>();
    for (int i = 0; i < point; i ++) {
      pointList.add(new PVector(random(width), random(height)));
    }
    
    initialize(point, maxPlayer);

    for (int i = 0; i < players.size(); i++) {
      setDistance(players.get(i));
    }
    sortDistance();
    
    this.p = p;
  }
  
  public void initialize(int point, int maxPlayer) {
    int random1, random2;
    int temp;
    
    players = new ArrayList<Individual>();
    
    for (int i = 0; i < maxPlayer; i++) {
      int[] gene = new int[point];
      
      for (int j = 0; j < point; j++) {
        gene[j] = j;
      }
      
      for (int j = 0; j < 20; j++) {
        random1 = int(random(point));
        
        do {
          random2 = int(random(point));
        } while (random1 == random2);
        
        temp = gene[random2];
        gene[random2] = gene[random1];
        gene[random1] = temp;
      }
      
      players.add(new Individual(gene));
    }
  }
  
  public void mating (int maxPairing) {
    int size = players.size();
    
    int father, mother;
    Cross c;
    
    for (int i = 0; i < maxPairing; i++) {
      father = int(random(size));
      
      do {
        mother = int(random(size));
      } while (mother == father);
      
      c = new Cross(players.get(father), players.get(mother), p);
      
      players.add(c.son);
      players.add(c.daughter);
    }
    
    for (int i = 0; i < players.size(); i++) {
      setDistance(players.get(i));
    }
    sortDistance();
    
    selection();
    generation++;
  }
  
  public void selection () {
    ArrayList<Individual> newGeneration = new ArrayList<Individual>();
    int proportion = 4;
    
    for (int i = 0; i < maxPlayer / proportion; i++) {
      newGeneration.add(players.get(i));
    }
    
    int[] tempList = new int[maxPlayer - maxPlayer / proportion];
    int rand;
    boolean flg;
    
    for (int i = maxPlayer / proportion; i < maxPlayer; i++) {
      flg = false;
      
      while (true) {
        rand = int(random(maxPlayer / proportion, maxPlayer));
        
        for (int j = 0; j < tempList.length; j++) {
          if (tempList[j] == rand) {
            break;
          } 
          else if (j == tempList.length - 1) {
            flg = true;
          }
        }
        
        tempList[i - maxPlayer / proportion] = rand;
        
        if (flg) {
          break;
        }
      }
    }
    
    for (int i = 0; i < tempList.length; i++) {
      newGeneration.add(players.get(tempList[i]));
      
    }    
    /*
    int sum = 0;
    int roulette = 0;
    int point = 0;
    
    for (int i = maxPlayer / proportion; i < players.size(); i++) {
      sum += (players.size() - i);
    }
    
    for (int i = maxPlayer / proportion; i < maxPlayer; i++) {
      roulette = int(random(sum));
      point = 0;
      
      for (int j = int(maxPlayer / proportion); j < players.size(); j++) {
        point += (players.size() - j);
        if (point >= )
      }
    }
    */
    
    players = newGeneration;
  }
  
  // set distance to an individual 
  public void setDistance (Individual n) {
    float distance = 0;
    float dx, dy;
    
    for (int i = 0; i < n.gene.length; i++) {
      dx = pointList.get(n.gene[i]).x - pointList.get(n.gene[(i + 1) % n.gene.length]).x;
      dy = pointList.get(n.gene[i]).y - pointList.get(n.gene[(i + 1) % n.gene.length]).y;
      
      distance += sqrt(sq(dx) + sq(dy));
    }
    
    n.distance = distance;
  }
  
  public void sortDistance() {
    for (int i = 0; i < players.size() - 1; i++) {
      for (int j = players.size() - 1; j > i; j--) {
        if (players.get(j).distance <= players.get(j - 1).distance) {
          Individual temp = players.get(j);
          players.set(j, players.get(j - 1));
          players.set(j - 1, temp);
        }
      }
    }
  }
  
  public void addCity (float x, float y) {
    pointList.add(new PVector(x, y));
    ArrayList<Individual> temp = new ArrayList<Individual>();
    
    int rand = 0;
    for (int i = 0; i < players.size(); i++) {
      int[] newGene = new int[players.get(i).gene.length + 1];
      rand = int(random(players.get(i).gene.length + 1));
      
      for (int j = 0; j < players.get(i).gene.length + 1; j++) {
        if (j > rand) {
          newGene[j] = players.get(i).gene[j - 1];
        }
        else if (j < rand){
          newGene[j] = players.get(i).gene[j];
        }
        else {
          newGene[j] = pointList.size() - 1;
        }
      }
      
      temp.add(new Individual(newGene));
    }

    players = temp;
  }
}