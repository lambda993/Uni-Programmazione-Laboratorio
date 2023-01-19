;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define num-succ ;genera il numero successivo al numero inserito, nella base inserita
  (lambda(base numero) ;parametri(string, string): base in cui il numero è rappresentato, numero su cui lavorare
    (if (= (string-length numero) 0)
          (substring base 1 2)
     (let
        (
         (zero (substring base 0 1))
         (max-cifra-base(substring base (- (string-length base) 1)))
         (ultima-cifra-numero(substring numero (- (string-length numero) 1)))
         )
          (if (string=? ultima-cifra-numero max-cifra-base)
              (string-append (num-succ base (substring numero 0 (- (string-length numero) 1)))
                             zero)
              (string-append (substring numero 0 (- (string-length numero) 1))
                             (prossima-cifra base (substring numero (- (string-length numero) 1))))
              )
      )
     )
    ))

(define prossima-cifra
  (lambda (base cifra)
     (if (string=? cifra (substring base 0 1))
         (string (string-ref base 1))
         (prossima-cifra (substring base 1) cifra)
         )
    ))

(define num-pred
  (lambda (base numero)
    (if (= (string-length numero) 1)
        (num-pred-cor base numero)
        (normalizza base (num-pred-cor base numero))
        )
    ))

(define num-pred-cor
  (lambda (base numero)
    (if (and (= (string-length numero) 1) (string=? numero (substring base 1 2)))
        (substring base 0 1)
        (let(
             (ultima-cifra-base (substring base (- (string-length base) 1)))
             (ultima-cifra-numero (substring numero (- (string-length numero) 1)))
             (zero (substring base 0 1)))
             
             (if (string=? ultima-cifra-numero zero)
                 (string-append (num-pred base (substring numero 0 (- (string-length numero) 1)))
                                ultima-cifra-base)
                 (string-append (substring numero 0 (- (string-length numero) 1))
                                (precedente-cifra base (substring numero (- (string-length numero) 1))))
                 )
             )
        )
    ))

(define precedente-cifra
  (lambda (base cifra)
    (if (string=? cifra (substring base (- (string-length base) 1)))
        (substring base (- (string-length base) 2) (- (string-length base) 1))
        (precedente-cifra (substring base 0 (- (string-length base) 1)) cifra)
        )
    ))

(define normalizza
  (lambda (base numero)
    (if (= (string-length numero) 0)
        ""
        (if (string=? (substring base 0 1) (substring numero 0 1))
            (normalizza base (substring numero 1))
            numero
            )
        )
    ))

(num-succ "01" "0");"1"

(num-succ "01" "11");"100"

(num-succ "zu" "uzu");"uuz"

(num-succ "zu" "uuuu");"uzzzz"

(num-succ "0123" "13");"20"

(num-succ "0123" "33");"100"

(num-pred "01" "1");"0"

(num-pred "01" "100");"11"

(num-pred "zu" "uuz");"uzu"

(num-pred "zu" "uzzzz");"uuuu"

(num-pred "0123" "20");"13"

(num-pred "0123" "100");"33"