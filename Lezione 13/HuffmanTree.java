import huffman_toolkit.*;

public class HuffmanTree{
  
  protected Node radice;
  protected String sRadice;
  
  public HuffmanTree(Node n){
    
    this.radice = n;
    this.sRadice = "";
  }
  
  public HuffmanTree(String src){
    
    this.radice = null;
    this.sRadice = src;
  }
  
  public Node root(){
    
    if(radice != null)
      return radice;
    
    InputTextFile in = new InputTextFile(sRadice);
    Node n = componiRadice(in);
    in.close();
    
    return n;
  }
  
  private Node componiRadice(InputTextFile in){
    
    char c = in.readChar();
    
    if(c == '@'){
      Node sinistro = componiRadice(in);
      Node destro = componiRadice(in);
      
      return new Node(sinistro, destro);
    }else{
      if(c == '\\')
        c = in.readChar();
      
      return new Node(c, 0);
    }
  }
  
  public void save(String dst){
    
    OutputTextFile out = new OutputTextFile(dst);
    String r = componiRadiceString(radice);
    
    out.writeTextLine(r);
    
    out.close();
  }
  
  private String componiRadiceString(Node n){
    
    if(n.foglia()){
      char c = n.getCarattere();
      
      if(c == '\\' || c == '@')
        return "\\" + c;
      else
        return "" + c;
    }else{
      return "@" + componiRadiceString(n.getSinistro()) + componiRadiceString(n.getDestro());
    }
  }
}

/*
int[] freq = Huffman2.charHistogram( "Huffman2.java" );
HuffmanTree tree1 = new HuffmanTree( Huffman2.huffmanTree(freq) );
tree1.save( "H.txt" );
HuffmanTree tree2 = new HuffmanTree( "H.txt" );
Huffman2.flattenTree( tree2.root() );
*/