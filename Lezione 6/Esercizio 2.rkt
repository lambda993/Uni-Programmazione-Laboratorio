;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 2|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))

;; L-Tessellation Problem
;; Claudio Mirolo, 6/11/2014

;; Per eseguire questo codice e' necessario
;; utilizzare il TeachPack "drawings.ss"


;; L-Tessellation Problem
;;
;; Questo problema si basa su tasselli a forma di L, con
;; i lati lunghi di 2 unita' e quelli corti di 1 unita'.
;; La forma di ogni tassello, nella configurazione di
;; riferimento, e' associata al nome
;;
;;   L-tile
;;
;; Hai a disposizione tanti tasselli quanti ne servono e li
;; puoi spostare e combinare fra loro con le procedure:
;;
;;   (shift-down <figura> <passi>)
;;
;;   (shift-right <figura> <passi>)
;;
;;   (quarter-turn-right <figura>)
;;
;;   (quarter-turn-left <figura>)
;;
;;   (half-turn <figura>)
;;
;;   (glue-tiles <figura> <figura>)
;;
;; L'argomento <figura> e' nel caso piu' semplice un tassello e in
;; generale una figura ottenuta spostando, ruotando e combinando
;; diversi tasselli. L'argomento <passi> rappresenta il numero di
;; unita' di spostamento in basso o a destra.
;;
;; Le operazioni consentono, rispettivamente, di spostae in basso,
;; spostare a destra, ruotare di 90 gradi in senso orario, ruotare
;; di 90 gradi in senso antiorario, capovolgere e combinare
;; insieme due figure: si capisce facilmente provando, per esempio:
;;
;;   (glue-tiles L-tile (shift-right (half-turn L-tile) 1))
;;
;; Immagina che i tasselli rappresntino piastrelle con le quali
;; si deve coprire (o piastrellare) il pavimento di una stanza,
;; ma senza tagliare (o, peggio, sovrapporre) piastrelle.
;; Il problema e' risolubile se il pavimento della stanza e'
;; un quadrato di lato n unita', dove n e' una potenza di due,
;; da cui e' stata tolta una colonna quadrata di lato 1 unita'
;; in corrispondenza al vertice in basso a destra.
;; L'obiettivo e' di definire un'opportuna procedura in Scheme
;; "per piastrellare il pavimento" (naturalmente, se la forma e
;; le dimensioni sono consistenti con le specifiche date).


;; Traslazione unitaria da utilizzare per la tassellazione
;; (lato piu' corto del tassello a forma di L)

(set-tessellation-shift-step!)

(define S-tessellation
  (lambda (dim i j)
    (if (<= dim 2)
        (cond
          ((and (<= i 1) (<= j 1))
           (half-turn L-tile))
          ((and (<= i 1) (>= j 2))
           (quarter-turn-left L-tile))
          ((and (>= i 2) (<= j 1))
           (quarter-turn-right L-tile))
          (else
           L-tile)
          )
        (cond
          ((and (<= i (/ dim 2)) (<= j (/ dim 2)))
           (glue-tiles (half-turn (L-tessellation dim)) (S-tessellation (/ dim 2) (arrotola (/ dim 2) i) (arrotola (/ dim 2) j))))
          ((and (<= i (/ dim 2)) (> j (/ dim 2)))
           (glue-tiles (quarter-turn-left (L-tessellation dim)) (shift-right (S-tessellation (/ dim 2) (arrotola (/ dim 2) i) (arrotola (/ dim 2) j)) (/ dim 2))))
          ((and (> i (/ dim 2)) (<= j (/ dim 2)))
           (glue-tiles (quarter-turn-right (L-tessellation dim)) (shift-down (S-tessellation (/ dim 2) (arrotola (/ dim 2) i) (arrotola (/ dim 2) j)) (/ dim 2))))
          (else
           (glue-tiles (L-tessellation dim) (shift-down (shift-right (S-tessellation (/ dim 2) (arrotola (/ dim 2) i) (arrotola (/ dim 2) j)) (/ dim 2)) (/ dim 2))))
          )
        )
    ))

(define L-tessellation
  (lambda (dim)
    (if (<= dim 2)
        L-tile
        (if (= dim 4)
           (glue-tiles (glue-tiles (glue-tiles L-tile (shift-right (quarter-turn-right L-tile) 2))
                                   (shift-down (shift-right L-tile 1) 1))
                       (shift-down (quarter-turn-left L-tile) 2))

           (glue-tiles (glue-tiles (glue-tiles (L-tessellation (/ dim 2)) (shift-right (quarter-turn-right (L-tessellation (/ dim 2))) (/ dim 2)))
                                   (shift-down (shift-right (L-tessellation (/ dim 2)) (/ dim 4)) (/ dim 4)))
                       (shift-down (quarter-turn-left (L-tessellation (/ dim 2))) (/ dim 2)))
           )
        )
    ))

(define arrotola
  (lambda (dim n)
    (if (> n dim)
        (abs (- dim n))
        n
        )
    ))

;(L-tessellation 16)

;(glue-tiles (glue-tiles (glue-tiles L-tile (shift-right (quarter-turn-right L-tile) 2)) (shift-down (shift-right L-tile 1) 1)) (shift-down (quarter-turn-left L-tile) 2))

(S-tessellation 2 2 1)

(S-tessellation 4 4 1)

(S-tessellation 8 4 5)

(S-tessellation 32 12 21)