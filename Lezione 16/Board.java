public class Board{
  
  protected int[][] board;
  protected int nRegine;
  
  public Board(int n){
    
    this.nRegine = 0;
    this.board = new int[n+1][n+1];
    
    for(int i = 0; i <= n; i++)
      for(int j = 0; j <= n; j++)
      this.board[i][j] = 0;
  }
  
  public void addQueen(int i, int j){
    
    if(!underAttack(i, j)){
      board[i][j] = 1;
      nRegine++;
    }
  }
  
  public void removeQueen(int i, int j){
    
    if(board[i][j] == 1){
      board[i][j] = 0;
      nRegine--;
    }
  }
  
  public int size(){
    
    return board.length - 1;
  }
  
  public int queensOn(){
    
    return nRegine;
  }
  
  public boolean underAttack(int i, int j){
    
    return rigaA(i) || colonnaA(j) || diagonaleDestraA(i, j) || diagonaleSinistraA(i, j);
  }
  
  private boolean rigaA(int i){
    
    for(int j = 1; j <= size(); j++)
      if(board[i][j] == 1)
      return true;
    
    return false;
  }
  
  private boolean colonnaA(int j){
    
    for(int i = 1; i <= size(); i++)
      if(board[i][j] == 1)
      return true;
    
    return false;
  }
  
  private boolean diagonaleDestraA(int i, int j){
    
    int a = i, b = j;
    
    while(a <= size() && b <= size()){
      if(board[a][b] == 1)
        return true;
      
      a++;
      b++;
    }
    
    a = i;
    b = j;
    
    while(a >= 1 && b >= 1){
      if(board[a][b] == 1)
        return true;
      
      a--;
      b--;
    }
    
    return false;
  }
  
  private boolean diagonaleSinistraA(int i, int j){
    
    int a = i, b = j;
    
    while(a <= size() && b >= 1){
      if(board[a][b] == 1)
        return true;
      
      a++;
      b--;
    }
    
    a = i;
    b = j;
    
    while(a >= 1 && b <= size()){
      if(board[a][b] == 1)
        return true;
      
      a--;
      b++;
    }
    
    return false;
  }
  
  public String arrangement(){
    
    String risultato = "\n";
    
    for(int i = 1; i <= size(); i++){
      for(int j = 1; j <= size(); j++){
        if(board[i][j] == 1)
          risultato += "x ";
        else
          risultato += "o ";
      }
      risultato += "\n";
    }
    
    return risultato;
  }
  
  public boolean isFreeRow(int i){
    
    return !rigaA(i);
  }
  
  public void addQueen(String pos){
    
    int r = (int) pos.charAt(0) - 'a';
    int c = (int) pos.charAt(1) - '1';
    
    if((r <= size() && c <= size()) && (r >= 0 && c >= 0)){
      addQueen(r+1, c+1);
    }
  }
  
  public static void listOfCompletions(Board b){
    int n = b.size(), q = b.queensOn();
    
    if(q == n){
      System.out.println(b.arrangement());
    }else{
      int i = 1;
      
      while(!b.isFreeRow(i)){
        i++;
      }
      
      for(int j = 1; j <= n; j++){
        if(!b.underAttack(i, j)){
          b.addQueen(i, j);
          listOfCompletions(b);
          b.removeQueen(i, j);
        }
      }
    }
  }
}

//Board.listOfCompletions(new Board(8));
//b.addQueen( "b6" )