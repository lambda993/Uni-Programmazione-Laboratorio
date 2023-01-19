;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
 
;; Problema delle "n regine"
;;
;; Ultimo aggiornamento: 20/03/13
 
 
;; Dato astratto configurazione della "scacchiera"
;;
;; Operazioni:
;;
;;   (empty-board n)        :  interi -> scacchiere
;;
;;   (size B)               :  scacchiere -> interi
;;
;;   (queens-on B)          :  scacchiere -> interi
;;
;;   (under-attack? B i j)  :  scacchiere x indici x indici -> booleani
;;
;;   (add-queen B i j)      :  scacchiere x indici x indici -> scacchiere
;;
;;   (arrangement B)        :  scacchiere -> descrizioni
;;
;;
;; (empty-board n) :        Costruttore della scacchiera n x n vuota;
;; (size B) :               Dimensione n della scacchiera B;
;; (queens-on B) :          Numero di regine collocate nella scacchiera B;
;; (under-attack? B i j) :  La posizione i j e' sotto scacco?
;; (add-queen B j) :        Scacchiera che si ottiene dalla configurazione B
;;                          aggiungendo una nuova regina in posizione i j
;;                          (si assume che la posizione non sia sotto scacco);
;; (arrangement B) :        Descrizione "esterna" della configurazione
;;                          (esempi: lista di posizioni, stringa, immagine).
 
 
;; I. Numero di soluzioni:
 
 
;; Il numero di modi diversi in cui si possono disporre n regine
;;
;;   (number-of-arrangements n)
;;
;; in una scacchiera n x n e' dato dal numero di modi diversi in
;; cui si puo' completare la disposizione delle regine a partire
;; da una scacchiera n x n inizialmente vuota
;;
;;   (number-of-completions (empty-board n))
 
(define number-of-arrangements  ; valore: intero
  (lambda (n)                   ; n: intero positivo
    (number-of-completions (empty-board n))
    ))
 
 
;; Il numero di modi in cui si puo' completare la disposizione a
;; partire da una scacchiera parzialmente configurata
;;
;;   (number-of-completions board)
;;
;; in cui le k righe piu' in alto (0 <= k < n) sono occupate da
;; regine si puo' determinare a partire dalle configurazioni che
;; si ottengono aggiungendo una regina nella riga k+1 in tutti i
;; modi possibili
;;
;;   (sibling-boards board),
;;
;; calcolando ricorsivamente per ciascuna di esse il numero di
;; modi in cui si puo' completare la disposizione
;;
;;   (map number-of-completions (sibling-boards board))
;;
;; e sommando i valori che ne risultano
;;
;;   (list-sum (map number-of-completions (sibling-boards board))).
;;
;; Se invece la scacchiera rappresenta una soluzione (k = n)
;; c'e' un solo modo (banale) di completare la disposizione:
;; lasciare le cose come stanno
 
(define number-of-completions   ; valore: intero
  (lambda (board)               ; board: scacchiera
    (if (= (queens-on board) (size board))
        1
        (list-sum
         (map number-of-completions (siblings-of board))
         ))
    ))
 
 
;; La lista delle configurazione ddella scacchiera
;; discendenti dirette di una data configurazione
;;
;;   (sibling-boards board)
;;
;; include tutte le disposizioni che si ottengono aggiungendo
;; una regina nella prima riga libera, considerando tutte le
;; posizioni da colonna 1 in avanti
;;
;;   (siblings-from 1 board)
 
(define siblings-of             ; valore: lista di scacchiere
  (lambda (board)               ; board: scacchiera
    (siblings-from 1 board)
    ))
 
;; La lista delle scacchiere "figlie" di una data scacchiera
;; e ottenute aggiungendo una regina nella prima riga libera,
;; di indice i, a partire dalla colonna j in avanti
;;
;;   (siblings-from j board)
;;
;; - e' vuota se j > n, dove n = dimensione della scacchiera;
;;
;; - e' data da quelle che si ottengono a partire dalla
;;   posizione <i,j+1>
;;
;;   (siblings-from (+ j 1) board)
;;
;;   se la posizione <i,j> e' sotto scacco;
;;
;; - include (add-queen board i j) oltre a queste
;;
;;   (cons (add-next-queen board i j)
;;         (siblings-from (+ j 1) board)))
;;
;;   se la posizione <i,j> non e' sotto scacco;
 
(define siblings-from           ; valore: lista di scacchiere
  (lambda (j board)             ; j: indice, board: scacchiera
    (let ((i (+ (queens-on board) 1)))
      (cond ((> j (size board))
             null)
            ((under-attack? board i j)
             (siblings-from (+ j 1) board))
            (else
             (cons (add-queen board i j) (siblings-from (+ j 1) board)))
            ))
    ))
 
 
;; Somma degli interi di una lista
 
(define list-sum                ; valore: intero
  (lambda (nums)                ; nums: lista di interi
    (if (null? nums)
        0
        (+ (car nums) (list-sum (cdr nums)))
        )
    ))
 
 
;; II. Lista delle soluzioni:
 
 
;; Confronta il programma precedente!
 
 
(define list-of-arrangements    ; valore: lista di descrizioni
  (lambda (n)                   ; n: intero positivo
    (list-of-completions (empty-board n))
    ))
 
 
(define list-of-completions     ; valore: lista di descrizioni
  (lambda (board)               ; board: scacchiera
    (if (= (queens-on board) (size board))
        (list (arrangement board))
        (list-merge
         (map list-of-completions (siblings-of board))
         ))
    ))
 
 
(define list-merge              ; valore: lista di descrizioni
  (lambda (sublists)            ; sublists: lista di liste di descrizioni
    (if (null? sublists)
        null
        (append (car sublists) (list-merge (cdr sublists)))
        )
    ))
 
 
;; Realizzazione del dato astratto "scacchiera"

(define empty-board             ; scacchiera vuota n x n
  (lambda (n)
    (list
     n                          ; 1) dimensione scacchiera
     0                          ; 2) numero regine collocate sulla scacchiera
     null                       ; 3) lista righe sotto scacco
     null                       ; 4) lista colonne sotto scacco
     null                       ; 5) lista diagonali \ sotto scacco
     null                       ; 6) lista diagonali / sotto scacco
     (chessboard-image n)       ; 7) immagine della scacchiera
     )
    ))

(define size                    ; dimensione scacchiera
  car
  )

(define queens-on               ; numero regine collocate sulla scacchiera
  cadr
  )

(define under-attack?           ; e' sotto scacco la posizione <i,j> ?
  (lambda (board i j)           ; i, j in [1, n]  per n = (size board)
    (if (or (contiene? (list-ref board 2) i)
            (contiene? (list-ref board 3) j)
            (contiene-diag? (list-ref board 4) i j)
            (contiene-diag? (list-ref board 5) i j))
        #true
        #false
        )
    ))

(define contiene?
  (lambda (righe-colonne n)
    (if (= (length righe-colonne) 0)
        #false
        (if (= (car righe-colonne) n)
            #true
            (contiene? (cdr righe-colonne) n)
            )
        )
    ))

(define contiene-diag?
  (lambda (diagonali i j)
    (if (= (length diagonali) 0)
        #false
        (if (and (= (caar diagonali) i) (= (cadar diagonali) j))
            #true
            (contiene-diag? (cdr diagonali) i j)
            )
        )
    ))

(define add-queen               ; valore: scacchiera con una nuova regina
  (lambda (board i j)           ;         in posizione <i,j>
    (if (under-attack? board i j)
        board
        (list (size board)
              (+ (queens-on board) 1)
              (append (list-ref board 2) (list i))
              (append (list-ref board 3) (list j))
              (append (list-ref board 4) (destre (size board) i j))
              (append (list-ref board 5) (sinistre (size board) i j))
              (arrangement board))
        )
    ))

(define destre
  (lambda (dim i j)
    (append (destre-giu dim (+ i 1) (+ j 1)) (destre-su i j))
    ))

(define destre-giu
  (lambda (dim i j)
    (if (or (> i dim) (> j dim))
        null
        (append (list (list i j)) (destre-giu dim (+ i 1) (+ j 1)))
        )
    ))

(define destre-su
  (lambda (i j)
    (if (or (= i 0) (= j 0))
        null
        (append (list (list i j)) (destre-su (- i 1) (- j 1)))
        )
    ))

(define sinistre
  (lambda (dim i j)
    (append (sinistre-giu dim (+ i 1) (- j 1)) (sinistre-su dim i j))
    ))

(define sinistre-giu
  (lambda (dim i j)
    (if (or (> i dim) (= j 0))
        null
        (append (list (list i j)) (sinistre-giu dim (+ i 1) (- j 1)))
        )
    ))

(define sinistre-su
  (lambda (dim i j)
    (if (or (= i 0) (> j dim))
        null
        (append (list (list i j)) (sinistre-su dim (- i 1) (+ j 1)))
        )
    ))

(define arrangement             ; descrizione della scacchiera: immagine
  (lambda (board)
    (if (= (queens-on board) 0)
        (chessboard-image (size board))
        (add-queen-image (car (list-ref board 2))
                         (car (list-ref board 3))
                         (size board)
                         (arrangement (list
                                       (size board)
                                       (- (queens-on board) 1)
                                       (cdr (list-ref board 2))
                                       (cdr (list-ref board 3))
                                       (list-ref board 4)
                                       (list-ref board 5))))
        )
    ))

;(arrangement (add-queen (add-queen (empty-board 5) 3 3) 5 4))
 
;(arrangement (add-queen (add-queen (empty-board 4) 2 4) 1 2))
 
;(arrangement (add-queen (empty-board 4) 2 4))
 
;(arrangement (empty-board 4))

(number-of-arrangements 1)

(list-of-arrangements 1)

(number-of-arrangements 2)

(list-of-arrangements 2)

(number-of-arrangements 3)

(list-of-arrangements 3)

(number-of-arrangements 4)

(list-of-arrangements 4)

(number-of-arrangements 5)

(list-of-arrangements 5)

(number-of-arrangements 6)

(list-of-arrangements 6)