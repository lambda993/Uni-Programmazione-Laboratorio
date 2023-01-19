import huffman_toolkit.*;
import java.util.*;

public class Huffman3{
  
  public static Node alberoEfficente(int[] freq, String fileStats, String fInput){
    
    double[] statistica = new double[((int) 'z') - ((int) 'a') + 1];
    //System.out.println(statistica.length);
    long nCaratteri = contaCaratteri(fInput);
    //System.out.println(nCaratteri);
    PriorityQueue<Node> queue = new PriorityQueue<Node>();
    InputTextFile in = new InputTextFile(fileStats);
    
    for(int i = 0; i < statistica.length; i++){
      statistica[i] = Double.parseDouble(in.readTextLine().substring(2));
      //System.out.println(statistica[i]);
    }
    
    in.close();
    
    for(int i = (int) 'a'; i <= (int) 'z'; i++){
      freq[i] = (int) Math.round((nCaratteri * statistica[i - ((int) 'a')]) / 100.0);
      //System.out.println((char) i + " " + freq[i]);
    }
    
    for ( int c = 0; c < InputTextFile.CHARS; c++ ) {
      if ( freq[c] > 0 ) {
        Node n = new Node( (char) c, freq[c] );
        queue.add( n );
    }}
    while ( queue.size() > 1 ) {
    
      Node l = queue.poll();
      Node r = queue.poll();
      
      Node n = new Node( l, r );
      queue.add( n );
    }
    return queue.poll();  
  }
  
  private static long contaCaratteri(String fInput){
    
    long risultato = 0;
    InputTextFile in = new InputTextFile(fInput);
    
    while(in.textAvailable()){
      char c = in.readChar();
      risultato++;
    }
    
    in.close();
    
    return risultato;
  }
  
  public static int[] charHistogram( String src ) {
  
    InputTextFile in = new InputTextFile( src );
    
    int[] freq = new int[ InputTextFile.CHARS ];
    
    for ( int c = 0; c< InputTextFile.CHARS; c++) {
      freq[c] = 0;
    }
    
    while ( in.textAvailable() ) {
    
      int c = in.readChar();
      freq[c] = freq[c] + 1;
    }
    in.close();
    
    return freq;
  }
  
  public static String[] huffmanCodesTable( Node root ) {
  
    String[] codes = new String[ InputTextFile.CHARS ];
    
    fillTable( root, "", codes );
    
    return codes;
  }
  
  private static void fillTable( Node n, String code, String[] codes ) {
  
    if ( n.foglia() ) {
      codes[ n.getCarattere() ] = code;
    } else {
      fillTable( n.getSinistro(),  code+"0", codes );
      fillTable( n.getDestro(), code+"1", codes );
    }
  }
  
  public static String flattenTree( Node n ) {
    
    if ( n.foglia() ) {
      char c = n.getCarattere();
      if ( (c == '\\') || (c == '@') ) {
        return ( "\\" + c );
      } else {
        return ( "" + c );
      }
    } else {
      return ( "@"
             + flattenTree( n.getSinistro() )
             + flattenTree( n.getDestro() )
               );
    }
  }
  
  public static void compress( String src, String dst ) {

    int[] freq = charHistogram( src );
    
    Node root = alberoEfficente( freq, "Statistiche.txt", src );
    
    /*for(int i = 0; i < freq.length; i++)
      System.out.println(i + " " + (char) i + " " + freq[i]);*/
    
    int count = root.getPeso();
    String[] codes = huffmanCodesTable( root );
    
    /*for(int i = 0; i < codes.length; i++)
      System.out.println(i + " " + codes[i]);*/
    
    InputTextFile in = new InputTextFile( src );
    
    OutputTextFile out = new OutputTextFile( dst );
    
    out.writeTextLine( "" + count );
    out.writeTextLine( flattenTree(root) );
    
    for ( int j=0; j<count; j=j+1 ) {
    
      char c = in.readChar();
      //System.out.println(c + " " + (int) c);
      out.writeCode( codes[c] );
    }
    in.close();
    out.close();
  }
  
  public static Node restoreTree( InputTextFile in ) {
  
    char c = (char) in.readChar();
    
    if ( c == '@' ) {
    
      Node left  = restoreTree( in );
      
      Node right = restoreTree( in );
      
      return new Node( left, right );
    
    } else {
      if ( c == '\\' ) {
        c = (char) in.readChar();
      }
      return new Node( c, 0 );
    }
  }
  
   public static void decompress( String src, String dst ) {
    
    InputTextFile in = new InputTextFile( src );
    
    int count = Integer.parseInt( in.readTextLine() );
    Node root = restoreTree( in );
    
    String dummy = in.readTextLine();
    
    OutputTextFile out = new OutputTextFile( dst );
    
    for ( int j=0; j<count; j=j+1 ) {
      
      char c = decodeNextChar( root, in );
      out.writeChar( c );
    }
    in.close();
    out.close();
  }
   
   private static char decodeNextChar( Node root, InputTextFile in ) {
  
    Node n = root;
    
    do {
      if ( in.readBit() == 0 ) {
        n = n.getSinistro();
      } else {
        n = n.getDestro();
      }
    } while ( !n.foglia() );
    
    return n.getCarattere();
  }
}

/*
Huffman3.compress("Sample.txt", "CompressedSample.txt");
Huffman3.compress("CompressedSample.txt", "DeCompressedSample.txt");
*/