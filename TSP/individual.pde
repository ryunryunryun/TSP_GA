public class Individual {
  int[] gene; // city list
  float distance;
  
  // create Individual with same 
  public Individual (int maxSize) {
    gene = new int[maxSize];
  }
  
  // set gene with same size
  public Individual (int[] gene) {
    this.gene = gene;
  }
  
  // return gene
  public int[] getGene () {
    return gene;
  }
  
  // set gene as given
  public void setGene (int[] g) {
    for (int i = 0; i < g.length; i++) {
      gene[i] = g[i];
    }
  }
  
  public void setIndexAsGiven (int index, int givenNum) {
    gene[index] = givenNum;
  }
  
  
}