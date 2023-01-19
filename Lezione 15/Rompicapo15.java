import java.util.*;
import puzzleboard.*;

public class Rompicapo15{
  
  protected int[][] tavoletta;
  protected int totCaselle;
  
  public Rompicapo15(int caselle){
    
    this.totCaselle = caselle;
    this.tavoletta = new int[caselle][caselle];
    posizionaTasselli();
  }
  
  private void posizionaTasselli(){
    int[] presenti = new int[totCaselle * totCaselle];
    Random r = new Random();
    int i = 0, j = 0, k = 0;
    
    for(int m = 0; m < presenti.length; m++)
      presenti[m] = -1;
    
    while(k < (totCaselle * totCaselle)){
      int a = r.nextInt(totCaselle * totCaselle);
      
      if(!presente(presenti, a)){
        presenti[k] = a;
        k++;
        tavoletta[i][j] = a;
        j++;
      }
      
      if(j == tavoletta[i].length && i != tavoletta.length){
        j = 0;
        i++;
      }
    }
  }
  
  private boolean presente(int[] presenti, int n){
    
    for(int i = 0; i < presenti.length; i++){
      if(presenti[i] == n)
        return true;
    }
    
    return false;
  }
  
  public boolean ordinati(){
    int[] ordine = estraiOrdine();
    
    if(ordine[(totCaselle * totCaselle) - 1] != 0)
      return false;
    
    for(int i = 1; i < ordine.length; i++){
      if(ordine[i-1] != i)
        return false;
    }
    
    return true;
  }
  
  private int[] estraiOrdine(){
    
    int[] risultato = new int[totCaselle * totCaselle];
    
    for(int i = 0, k = 0; i < tavoletta.length; i++){
      for(int j = 0; j < tavoletta[i].length; j++, k++){
        risultato[k] = tavoletta[i][j];
      }
    }
    
    return risultato;
  }
  
  public boolean spostabile(int i, int j){
    
    if(i == 0 && j == 0)
      return tavoletta[i][j+1] == 0 || tavoletta[i+1][j] == 0;
    
    if(i == 0 && j == (tavoletta[0].length - 1))
      return tavoletta[i][j-1] == 0 || tavoletta[i+1][j] == 0;
    
    if(i == (tavoletta.length - 1) && j == 0)
      return tavoletta[i-1][j] == 0 || tavoletta[i][j+1] == 0;
    
    if(i == (tavoletta.length - 1) && j == (tavoletta[i].length - 1))
      return tavoletta[i-1][j] == 0 || tavoletta[i][j-1] == 0;
    
    if(i == 0)
      return tavoletta[i][j-1] == 0 || tavoletta[i+1][j] == 0 || tavoletta[i][j+1] == 0;
    
    if(j == 0)
      return tavoletta[i-1][j] == 0 || tavoletta[i][j+1] == 0 || tavoletta[i+1][j] == 0;
    
    if(i == (tavoletta.length - 1))
      return tavoletta[i][j-1] == 0 || tavoletta[i-1][j] == 0 || tavoletta[i][j+1] == 0;
    
    if(j == (tavoletta[i].length - 1))
      return tavoletta[i-1][j] == 0 || tavoletta[i][j-1] == 0 || tavoletta[i+1][j] == 0;
    
    return tavoletta[i-1][j] == 0 || tavoletta[i][j+1] == 0 || tavoletta[i+1][j] == 0 || tavoletta[i][j-1] == 0;
  }
  
  public void stampaTavoletta(){
    
    for(int i = 0; i < tavoletta.length; i++){
      for(int j = 0; j < tavoletta[i].length; j++){
        System.out.print(tavoletta[i][j] + " ");
      }
      System.out.print("\n");
    }
  }
  
  public void sposta(int i, int j){
    
    if(spostabile(i, j)){
      int[] posB = posBuco();
      
      tavoletta[posB[0]][posB[1]] = tavoletta[i][j];
      tavoletta[i][j] = 0;
    }
  }
  
  private int[] posBuco(){
    
    for(int i = 0; i < tavoletta.length; i++)
      for(int j = 0; j < tavoletta[i].length; j++){
      if(tavoletta[i][j] == 0)
        return new int[]{i, j};
    }
    
    return null;
  }
  
  public void generaGUI(){
    
    PuzzleBoard gui = new PuzzleBoard(totCaselle);
    
    setup(gui);
    
    while(!ordinati()){
      int k = gui.get();
      int[] posGui = posizione(k);
      
      sposta(posGui[0], posGui[1]);
      setup(gui);
    }
    
    System.out.println("Programma Terminato");
  }
  
  private void setup(PuzzleBoard gui){
    
    for(int i = 0; i < tavoletta.length; i++)
      for(int j = 0; j < tavoletta[i].length; j++)
      gui.setNumber(i+1, j+1, tavoletta[i][j]);
    
    gui.display();
  }
  
  private int[] posizione(int n){
    
    for(int i = 0; i < tavoletta.length; i++)
      for(int j = 0; j < tavoletta[i].length; j++){
      if(tavoletta[i][j] == n)
        return new int[]{i, j};
    }
    
    return null;
  }
  
  public void risolto(){
    for(int i = 0, k = 1; i < tavoletta.length; i++)
      for(int j = 0; j < tavoletta[i].length; j++, k++)
      tavoletta[i][j] = k;
    
    tavoletta[tavoletta.length - 1][tavoletta.length - 1] = 0;
  }
}

/*
Rompicapo15 r = new Rompicapo15(4);
r.stampa();
r.generaGUI();
r.risolto();
*/