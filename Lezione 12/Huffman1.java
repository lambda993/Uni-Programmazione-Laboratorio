import huffman_toolkit.*;
import java.util.*;
  
public class Huffman1{
  
  private static final int chars = InputTextFile.CHARS;
  
  public static int[] istogramma(String input){
    
    InputTextFile sorgente = new InputTextFile(input);
    int[] caratteri = new int[chars];
    
    for(int i = 0; i < caratteri.length; i++)
      caratteri[i] = 0;
    
    while(sorgente.bitsAvailable()){
      caratteri[(int) sorgente.readChar()]++;
    }
    
    sorgente.close();
    
    return caratteri;
  }
  
  public static Node albero(int[] frequenze){
    
    PriorityQueue<Node> coda = new PriorityQueue<Node>();
    
    for(int i = 0; i < frequenze.length; i++){
      if(frequenze[i] > 0){
        Node nodo = new Node((char) i, frequenze[i]);
        coda.add(nodo);
      }
    }
    
    while(coda.size() > 1){
      Node sinistro = coda.poll();
      Node destro = coda.poll();
      
      Node nuovo = new Node(sinistro, destro);
      coda.add(nuovo);
    }
    
    return coda.poll();
  }
  
  public static String[] tabellaCodici(Node frequenze){
    
    String listaCodici[] = new String[chars];
    
    ottieniCodici(frequenze, "", listaCodici);
    
    return listaCodici;
  }
  
  private static void ottieniCodici(Node frequenze, String codiceAttuale, String[] listaCodici){
    
    if(frequenze.foglia()){
      listaCodici[(int) frequenze.getCarattere()] = codiceAttuale;
    }else{
      ottieniCodici(frequenze.getSinistro(), codiceAttuale + "0", listaCodici);
      ottieniCodici(frequenze.getDestro(), codiceAttuale + "1", listaCodici);
    }
  }
  
  public static void tabellaCaratteri(String sorgente, String destinazione){
    int[] frequenze = istogramma(sorgente);
    Node radice = albero(frequenze);
    String[] codici = tabellaCodici(radice);
    String risultato = componiStringaHuffman(frequenze, radice, codici);
    OutputTextFile output = new OutputTextFile(destinazione);
    
    risultato = risultato.substring(0, risultato.length() - 1);
    output.writeTextLine(risultato);
    
    output.close();
  }
  
  private static String componiStringaHuffman(int[] frequenze, Node radice, String[] codici){
    
    if(radice.foglia()){
      return Character.toString(radice.getCarattere()) + "\t" +
        frequenze[(int) radice.getCarattere()] + "\t" +
        codici[(int) radice.getCarattere()] + "\t" +
        codici[(int) radice.getCarattere()].length() + "\n";
    }else{
      return "" + componiStringaHuffman(frequenze, radice.getSinistro(), codici) +
        componiStringaHuffman(frequenze, radice.getDestro(), codici);
    }
  }
  
  public static void generaCaratteri(String output, long quantitaCaratteri){
    Random carattere = new Random();
    OutputTextFile out = new OutputTextFile(output);
    
    for(long i = 0; i < quantitaCaratteri; i++){
      int car =  carattere.nextInt() & 127;
      out.writeChar((char) car);
    }
    
    out.close();
  }
  
  public static long contaCaratteri(String input){
    
    long quantita = 0;
    InputTextFile in = new InputTextFile(input);
    
    while(in.textAvailable()){
      char c = in.readChar();
      quantita++;
    }
    
    in.close();
    
    return quantita;
  }
  
  public static void comprimi(String input, String output){
    
    int[] frequenze = istogramma(input);
    Node radice = albero(frequenze);
    int quantitaCaratteri = radice.getPeso();
    String[] codiciHuffman = tabellaCodici(radice);
    
    InputTextFile in = new InputTextFile(input);
    OutputTextFile out = new OutputTextFile(output);
    
    out.writeTextLine("" + quantitaCaratteri);
    out.writeTextLine(componiAlberoString(radice));
    
    for(int i = 0; i < quantitaCaratteri; i++){
      char c = in.readChar();
      out.writeCode(codiciHuffman[(int) c]);
    }
    
    in.close();
    out.close();
  }
  
  private static String componiAlberoString(Node albero){
    
    if(albero.foglia()){
      char c = albero.getCarattere();
      
      if((c == '\\') || (c == '@'))
        return "\\" + c;
      else
        return "" + c;
    }else{
      return "@" + componiAlberoString(albero.getSinistro()) + componiAlberoString(albero.getDestro());
    }
  }
  
  public static long stimaGrandezzaCompByte(String input){
    
    int[] freq = istogramma(input);
    Node radice = albero(freq);
    String[] codiciHuffman = tabellaCodici(radice);
    long risultato = 0;
    int intestazione = 0;
    
    for(int i = 0; i < freq.length; i++){
      if(freq[i] != 0)
        risultato += freq[i] * codiciHuffman[i].length();
    }
    
    risultato /= 7;
    
    for(int i = 0; i < freq.length; i++){
      if((char) i == '\\')
        intestazione += 2;
      else if((char) i == '@')
        intestazione += 0;
      else
        intestazione++;
    }
    
    risultato += intestazione + String.valueOf(radice.getPeso()).length();
    
    return risultato;
  }
}

//Huffman1.tabellaCaratteri("Sample.txt", "SampleOut.txt");

/*
Huffman1.generaCaratteri("Sample2.txt", Huffman1.contaCaratteri("Sample.txt"));
Huffman1.tabellaCaratteri("Sample2.txt", "SampleOut2.txt");
*/

/*
System.out.println(Huffman1.stimaGrandezzaCompByte("Sample.txt"));
System.out.println(Huffman1.stimaGrandezzaCompByte("Sample2.txt"));
Huffman1.comprimi("Sample.txt", "CompressedSample.txt");
Huffman1.comprimi("Sample2.txt", "CompressedSample2.txt");
*/