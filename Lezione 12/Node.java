public class Node implements Comparable<Node>{
  
  protected final Node sinistro, destro;
  protected final char carattere;
  protected final int peso;
  
  public Node(char carattere, int peso){
    
    this.carattere = carattere;
    this.peso = peso;
    this.sinistro = null;
    this.destro = null;
  }
  
  public Node(Node sinistro, Node destro){
    
    this.peso = sinistro.getPeso() + destro.getPeso();
    this.carattere = (char) 0;
    this.sinistro = sinistro;
    this.destro = destro;
  }
  
  public boolean foglia(){
    
    return sinistro == null;
  }
  
  public int getPeso(){
    
    return peso;
  }
  
  public Node getSinistro(){
    
    return sinistro;
  }
  
  public Node getDestro(){
    
    return destro;
  }
  
  public char getCarattere(){
    
    return carattere;
  }
  
  public int compareTo(Node n){
    
    if(peso == n.getPeso())
      return 0;
    
    if(peso > n.getPeso())
      return 1;
    
    return -1;
  }
}