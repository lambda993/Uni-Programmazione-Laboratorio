public class Esercizio1{
  
  public static int llcs3(String t, String u, String v){
    
    int[][][] stato = new int[t.length()+1][u.length()+1][v.length()+1];
    
    for(int i = 0; i < stato.length; i++)
      for(int j = 0; j < stato[i].length; j++)
      for(int k = 0; k < stato[i][j].length; k++)
      stato[i][j][k] = -1;
     
    return llcs3mem(t, u, v, stato);
  }
  
  private static int llcs3mem(String t, String u, String v, int[][][] stato){
    
    if(stato[t.length()][u.length()][v.length()] != -1){
      return stato[t.length()][u.length()][v.length()];
    }else{
      if(t.equals("") || u.equals("") || v.equals("")){
        stato[t.length()][u.length()][v.length()] = 0;
      }else if(t.charAt(0) == u.charAt(0) && u.charAt(0) == v.charAt(0)){
        stato[t.length()][u.length()][v.length()] = 1 + llcs3mem(t.substring(1), u.substring(1), v.substring(1), stato);
      }else{
        stato[t.length()][u.length()][v.length()] = massimo(llcs3mem(t.substring(1), u, v, stato),
                                                                  llcs3mem(t, u.substring(1), v, stato), 
      llcs3mem(t, u, v.substring(1), stato));
      }
    }
    
    return stato[t.length()][u.length()][v.length()];
  }
  
  private static int massimo(int a, int b, int c){
    
    return a >= b && a >= c ? a : b >= c ? b : c;
  }
  
  public static boolean mSimmetrica(int[][] M){
    
    if(M.length != M[0].length)
      return false;
    
    for(int i = 0; i < M.length; i++)
      for(int j = 0; j < M[i].length; j++)
      if(M[i][j] != M[j][i])
      return false;
    
    return true;
  }
}

//System.out.println(Esercizio1.llcs3("Gatto", "Matto", "Patto"))
//Esercizio1.mSimmetrica(new int[][]{{1,0,0},{0,1,0},{0,0,1}})