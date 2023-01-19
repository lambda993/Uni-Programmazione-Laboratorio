public class Esercizio1{
  
  public static long Stirling(int n, int k){
    
    if(k == 1 || k == n)
      return 1;
    else
      return Stirling(n - 1, k - 1) + (k * Stirling(n - 1, k));
  }
  
  public static String stirling(int n, int k){
    
    long[][] stato = new long[n + 1][];
    
    for(int i = 0; i <= n; i++){
      stato[i] = new long[i + 1];
      
      for(int j = 0; j <= i; j++){
        stato[i][j] = 0;
      }
    }
    
    long st = stirlingMem(n, k, stato);
    
    return visualizzazione(stato);
  }
  
  private static String visualizzazione(long[][] stato){
    
    String risultato = "";
    
    for(int i = 1; i < stato.length; i++){
      for(int j = 1; j < stato[i].length; j++){
        if(stato[i][j] == 0)
          risultato += "U ";
        else
          risultato += "C ";
      }
      risultato += "\n";
    }
    
    return risultato.substring(0, risultato.length() - 1);
  }
  
  private static long stirlingMem(int n, int k, long[][] stato){
    
    if(stato[n][k] == 0){      
      for(int i = 1; i <= n; i++){
        for(int j = 1; (j <= i) && (j <= k); j++){
          if(j == 1 || j == i){
            stato[i][j] = 1;
          }else{
          stato[i][j] = stato[i-1][j-1] + j * stato[i-1][j];
          }
        }
      }
    }
    
    return stato[n][k];
  }
}

//System.out.println(Esercizio1.Stirling(3, 2)); ===> 3
//System.out.println(Esercizio1.Stirling(6, 3)); ===> 90
//System.out.println(Esercizio1.Stirling(6, 4)); ===> 65
//System.out.println(Esercizio1.Stirling(6, 6)); ===> 1
//System.out.println(Esercizio1.Stirling(9, 5)); ===> 6951
//System.out.println(Esercizio1.Stirling(23, 12)); ===> 1672162773483930

//System.out.println(Esercizio1.stirling(3, 2));
//System.out.println(Esercizio1.stirling(6, 3));
//System.out.println(Esercizio1.stirling(6, 4));
//System.out.println(Esercizio1.stirling(6, 6));
//System.out.println(Esercizio1.stirling(9, 5));
//System.out.println(Esercizio1.stirling(23, 12));