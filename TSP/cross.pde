public class Cross {
  Individual father; // parent_1
  Individual mother; // parent_2
  
  Individual son; // child from father and mother
  Individual daughter;
  
  // set father and mother
  public Cross (Individual father, Individual mother, float mutationP) {
    this.father = father;
    this.mother = mother;
    
    reproduction(1, 1, mutationP);
  }
  
  public void reproduction(int breedIndex, int mutationIndex, float mutationP) {
    breed(breedIndex);
    
    if (random(1) <= mutationP) {
      mutation(mutationIndex, son);
    }
    if (random(1) <= mutationP) {
      mutation(mutationIndex, daughter);
    }
    
  }
  
  // 1. circular breeding
  // 2. partial breeding
  // 3. order breeding
  // 4. uniform order breeding
  // 5. uniform position breeding
  public void breed (int i) {
    switch (i) {
      case 1: circularBreeding();
      case 2: partialBreeding();
      case 3: orderBreeding();
      case 4: uniformOrderBreeding();
      case 5: uniformPositionBreeding();
    }
  }
  
  // 1. oppsite mutation
  // 2. scramble mutation
  // 3. exchange mutation
  // 4. transpose mutation
  public void mutation (int i, Individual n) {
    switch (i) {
      case 1: oppositeMutation (n);
      case 2: scrambleMutation (n);
      case 3: exchangeMutation (n);
      case 4: transposeMutation (n);
    }
  }
  
  //  f.  241365  ++1++5       321465
  //  m.  325416  ++5+1+       245316
  //
  //  a. select 1 random point of father (1)
  //  b. find (1)'s index from mother
  //  c. exchange all in the other's order
  private void circularBreeding () {
    int index = int(random(father.getGene().length));
    
    int randIndexF = 0, randIndexM = 0;
    
    index = 0;
    
    for (int i = 0; i < father.getGene().length; i ++) {
      if (father.getGene()[i] == mother.getGene()[index]) {
        randIndexF = i;
      }
    }
    
    for (int i = 0; i < mother.getGene().length; i ++) {
      if (mother.getGene()[i] == father.getGene()[index]) {
        randIndexM = i;
      }
    }
    
    int numF = father.getGene()[index];
    int numM = mother.getGene()[index];
    
    ArrayList<Integer> sonGene = new ArrayList<Integer>();
    ArrayList<Integer> daughterGene = new ArrayList<Integer>();
    int temp;
    
    // create son    
    for (int i = 0; i < mother.getGene().length; i++) {
      if (mother.getGene()[i] != numF && mother.getGene()[i] != numM) {
        sonGene.add(mother.getGene()[i]);
      }
    }
    
    if (index < randIndexF) {
      sonGene.add(index, numF);
      sonGene.add(randIndexF, numM);
    }
    else if (index == randIndexF) {
      sonGene.add(index, numF);
    }
    else {
      sonGene.add(randIndexF, numM);
      sonGene.add(index, numF);
    }
    
    // create daughter
    for (int i = 0; i < father.getGene().length; i++) {
      if (father.getGene()[i] != numF && father.getGene()[i] != numM) {
        daughterGene.add(father.getGene()[i]);
      }
    }
    
    if (index < randIndexM) {
      daughterGene.add(index, numM);
      daughterGene.add(randIndexM, numF);
    }
    else if (index == randIndexM) {
      daughterGene.add(index, numM);
    }
    else {
      daughterGene.add(randIndexM, numF);
      daughterGene.add(index, numM);
    }
    
    int[] sg = new int[father.gene.length];
    int[] dg = new int[mother.gene.length];
    
    for (int i = 0; i < sonGene.size(); i++) {
      sg[i] = sonGene.get(i);
    }
    
    for (int i = 0; i < daughterGene.size(); i++) {
      dg[i] = daughterGene.get(i);
    }
    
    son = new Individual(sg);
    daughter = new Individual(dg);
   
  }
  
  // 231|365    235416
  // 325|416    426351
  //
  // select partition part
  // 241|365  2314|65  23641|5  236451
  // 325|416  4253|16  42536|1  421365
  private void partialBreeding () {
    
  }
  
  // 24|1365   24|3516
  // 32|5416   32|4165
  // 
  // select partition
  // put the right indeces in the other's order
  private void orderBreeding () {
    
  }
  
  // recommended to be done in LinkedList
  // 245136(s 456)   214536
  // 314265(s 145)   314256
  //
  // select f's indeces randomly(456)
  // find m's same indeces(145)
  // re-order f's indeces of m's set as m's order
  // do the same for m
  private void uniformOrderBreeding () {
  }
  
  // recommended to be done in LinkedList
  // 4(1)(2)63(5)  -(2)(3)--(6)  4(2)(3)15(6)
  // 1(2)(3)45(6)  -(1)(2)--(5)  3(1)(2)46(5)
  // 
  // select f's indeces randomly
  // determine m's same indeces
  // substitute m's to f's indeces
  // put the others in the same order
  private void uniformPositionBreeding () {
  }
  
  // a(bcd)ef  a(dcb)ef
  private void oppositeMutation (Individual n) {
    int randFirst = int(random(n.getGene().length - 1));
    int randNext = int(random(randFirst + 1, n.getGene().length));
    int temp;
    
    for (int i = randFirst; i <= randFirst + (randNext - randFirst) / 2; i++) {
      temp = n.gene[i];
      n.setIndexAsGiven(i, n.gene[randNext - (i - randFirst)]);
      n.setIndexAsGiven(randNext - (i - randFirst), temp);
    }
  }
  
  // randomly reposition
  private void scrambleMutation (Individual n) {
  }
  
  // randomly exchange portions
  private void exchangeMutation (Individual n) {
  }
  
  // select two allele and put second one before first
  private void transposeMutation (Individual n) {
  }
}