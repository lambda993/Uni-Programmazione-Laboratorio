public class NodeQueue{
  
  protected Node[] coda;
  protected int dimensione;
  
  public NodeQueue(){
    
    this.coda = new Node[128];
    this.dimensione = 0;
  }
  
  public int size(){
    
    return dimensione;
  }
  
  public Node poll(){
    
    if(size() == 0)
      return null;
    
    Node ultimo = coda[size() - 1];
    dimensione--;
    
    return ultimo;
  }
  
  public void add(Node n){
    
    if(size() == 0){
      coda[0] = n;
      dimensione++;
    }else if(size() == 1){
      if(n.getPeso() < coda[0].getPeso()){
        coda[1] = n;
        dimensione++;
      }else{
        Node temp = coda[0];
        coda[0] = n;
        coda[1] = temp;
        dimensione++;
      }
    }else{
      int p = n.getPeso();
      boolean aggiunto = false;
      
      for(int i = 0; (i < size()) && (!aggiunto); i++){
        if(p > coda[i].getPeso()){
          aggiungiSposta(i, n);
          dimensione++;
          aggiunto = true;
        }
      }
      
      if(!aggiunto){
        coda[size()] = n;
        dimensione++;
      }
    }
  }
  
  private void aggiungiSposta(int elemento, Node oggettoElemento){
    
    for(int i = size(); i > elemento; i--)
      coda[i] = coda[i-1];
    
    coda[elemento] = oggettoElemento;
  }
  
  /*public void stampaCoda(){
    
    for(int i = 0; i < size(); i++)
      System.out.println(coda[i].getCarattere() + "\t" + coda[i].getPeso());
  }
  
  public void stampaDimensione(){
    
    System.out.println(dimensione);
  }*/
}