public class DistributoreAutomatico{
  
  protected final int costo;
  protected int dosi;
  protected int bicchierini;
  protected int[] moneteResto;
  protected int credito;
  
  public DistributoreAutomatico(int costo){
    
    this.costo = costo;
    this.dosi = 0;
    this.bicchierini = 0;
    this.moneteResto = new int[6];
    this.credito = 0;
    
    for(int i = 0; i < this.moneteResto.length; i++)
      this.moneteResto[i] = 0;
  }
  
  public void caricaDosi(int dosi){
    
    this.dosi += dosi;
    this.bicchierini += dosi;
  }
  
  public void caricaMonete(int numeroMonete, int valore){
    
    switch(valore){
      
      case 5:
        this.moneteResto[0] += numeroMonete;
        break;
        
      case 10:
        this.moneteResto[1] += numeroMonete;
        break;
        
      case 20:
        this.moneteResto[2] += numeroMonete;
        break;
        
      case 50:
        this.moneteResto[3] += numeroMonete;
        break;
        
      case 100:
        this.moneteResto[4] += numeroMonete;
        break;
        
      case 200:
        this.moneteResto[5] += numeroMonete;
        break;
        
      default:
    }
  }
  
  public void inserisciMoneta(int valore){
    
    this.credito += valore;
    this.caricaMonete(1, valore);
  }
  
  public void richiediCaffe(){
    
    if((this.credito >= this.costo) && !this.caffeEsaurito() &&
      this.restoRestituibile(this.credito - this.costo, this.clonaArray(this.moneteResto))){
      
      this.credito -= this.costo;
      this.dosi--;
      this.bicchierini--;
    }
  }
  
  private int[] clonaArray(int[] array){
    
    int[] risultato = new int[array.length];
    
    for(int i = 0; i < array.length; i++)
      risultato[i] = array[i];
    
    return risultato;
  }
  
  private boolean restoRestituibile(int quantita, int[] soldi){
    
    if(quantita >= this.valore(5) && soldi[5] > 0)
      return restoRestituibile(quantita - this.valore(5), this.decrementa(soldi, 5));
    
    if(quantita >= this.valore(4) && soldi[4] > 0)
      return restoRestituibile(quantita - this.valore(4), this.decrementa(soldi, 4));
    
    if(quantita >= this.valore(3) && soldi[3] > 0)
      return restoRestituibile(quantita - this.valore(3), this.decrementa(soldi, 3));
    
    if(quantita >= this.valore(2) && soldi[2] > 0)
      return restoRestituibile(quantita - this.valore(2), this.decrementa(soldi, 2));
    
    if(quantita >= this.valore(1) && soldi[1] > 0)
      return restoRestituibile(quantita - this.valore(1), this.decrementa(soldi, 1));
    
    if(quantita >= this.valore(0) && soldi[0] > 0)
      return restoRestituibile(quantita - this.valore(0), this.decrementa(soldi, 0));
    
    return quantita == 0;
  }
  
  private int[] decrementa(int[] soldi, int quale){
    
    soldi[quale] -= 1;
   
    return soldi;
  }
  
  private int valore(int moneta){
    
    switch(moneta){
      
      case 0:
        return 5;
        
      case 1:
        return 10;
        
      case 2:
        return 20;
        
      case 3:
        return 50;
        
      case 4:
        return 100;
        
      case 5:
        return 200;
        
      default:
    }
    
    return 0;
  }
  
  public void richiediResto(){
    
    if(this.restoRestituibile(this.credito, this.clonaArray(this.moneteResto))){
      this.moneteResto = this.eseguiResto(this.credito, this.clonaArray(this.moneteResto));
      this.credito = 0;
    }
  }
  
  private int[] eseguiResto(int credito, int[] monete){
    
    if(credito >= this.valore(5) && monete[5] > 0)
      return eseguiResto(credito - this.valore(5), this.decrementa(monete, 5));
    
    if(credito >= this.valore(4) && monete[4] > 0)
      return eseguiResto(credito - this.valore(4), this.decrementa(monete, 4));
    
    if(credito >= this.valore(3) && monete[3] > 0)
      return eseguiResto(credito - this.valore(3), this.decrementa(monete, 3));
    
    if(credito >= this.valore(2) && monete[2] > 0)
      return eseguiResto(credito - this.valore(2), this.decrementa(monete, 2));
    
    if(credito >= this.valore(1) && monete[1] > 0)
      return eseguiResto(credito - this.valore(1), this.decrementa(monete, 1));
    
    if(credito >= this.valore(0) && monete[0] > 0)
      return eseguiResto(credito - this.valore(0), this.decrementa(monete, 0));
    
    return monete;
  }
  
  public String leggiStato(){
    
    String risultato = "errore";
    
    if(!this.caffeEsaurito() && this.credito == 0)
      risultato = "in funzione";
    
    if(!this.caffeEsaurito() && this.restoRestituibile(this.credito, this.clonaArray(this.moneteResto))
         && this.credito > 0)
      risultato = "credito: " + this.credito + " centesimi";
    
    if(!this.caffeEsaurito() && this.credito >= this.costo &&
       !this.restoRestituibile(this.credito - this.costo, this.clonaArray(this.moneteResto)))
      risultato = "resto non disponibile per " + this.credito + " centesimi";
    
    if(this.caffeEsaurito())
      risultato = "caffe' esaurito";
    
    return risultato;
  }
  
  public boolean caffeEsaurito(){
    
    return (this.dosi <= 0) || (this.bicchierini <= 0);
  }
}

/*
DistributoreAutomatico distributore = new DistributoreAutomatico( 45 );

distributore.caricaDosi( 10 );
distributore.caricaMonete( 10, 5 );
distributore.caricaMonete( 8, 10 );
distributore.caricaMonete( 5, 20 );
distributore.caricaMonete( 5, 50 );
distributore.caricaMonete( 2, 100 );
distributore.caricaMonete( 1, 200 );

System.out.println( distributore.leggiStato() );

for ( int k=0; k<5; k=k+1 ) {
distributore.inserisciMoneta( 200 );

System.out.println( distributore.leggiStato() );

distributore.richiediCaffe();

System.out.println( distributore.leggiStato() );

distributore.richiediResto();

System.out.println( distributore.leggiStato() );
}

for ( int k=0; k<5; k=k+1 ) {
distributore.inserisciMoneta( 20 );
distributore.inserisciMoneta( 20 );
distributore.inserisciMoneta( 20 );

System.out.println( distributore.leggiStato() );

distributore.richiediCaffe();

System.out.println( distributore.leggiStato() );

distributore.richiediResto();

System.out.println( distributore.leggiStato() );
}

for ( int k=0; k<2; k=k+1 ) {
distributore.inserisciMoneta( 20 );
distributore.inserisciMoneta( 20 );
distributore.inserisciMoneta( 5 );

System.out.println( distributore.leggiStato() );

distributore.richiediCaffe();

System.out.println( distributore.leggiStato() );

distributore.richiediResto();

System.out.println( distributore.leggiStato() );
}
*/

/*
in funzione

credito: 200 cent
credito: 155 cent
in funzione
credito: 200 cent
credito: 155 cent
in funzione
credito: 200 cent
credito: 155 cent
in funzione
credito: 200 cent
credito: 155 cent

in funzione
resto non disponibile per 200 cent
resto non disponibile per 200 cent
in funzione
credito: 60 cent
credito: 15 cent
in funzione
credito: 60 cent
credito: 15 cent
in funzione
credito: 60 cent
credito: 15 cent
in funzione
credito: 60 cent
credito: 15 cent
in funzione
resto non disponibile per 60 cent
resto non disponibile per 60 cent
in funzione
credito: 45 cent
in funzione
in funzione
credito: 45 cent

caffe' esaurito
caffe' esaurito
*/