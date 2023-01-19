;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define prime-factors
  (lambda (n)
    (if (<= n 1)
        null
        (append (list (divisore-primo n 2)) (prime-factors (/ n (divisore-primo n 2))))
        )
    ))

(define divisore-primo
  (lambda (n cont)
    (if (= (modulo n cont) 0)
        cont
        (divisore-primo n (+ cont 1))
        )
    ))

(define short-prime-factors
 (lambda (n)
   (fattori (prime-factors n))
   ))

(define fattori
  (lambda (fact)
    (if (= (length fact) 0)
        null
        (append (list (car fact)) (fattori (rimuovi (car fact) (cdr fact))))
        )
    ))

(define rimuovi
  (lambda (n lista)
    (if (= (length lista) 0)
        null
        (if (not (= n (car lista)))
            lista
            (rimuovi n (cdr lista))
            )
        )
    ))

(prime-factors 7); '(7)

(prime-factors 9); '(3 3)

(prime-factors 28); '(2 2 7)

(prime-factors 39); '(3 13)

(prime-factors 540); '(2 2 3 3 3 5)

(prime-factors 1617); '(3 7 7 11)

"---------------------------------"

(short-prime-factors 7); '(7)

(short-prime-factors 9); '(3)

(short-prime-factors 28); '(2 7)

(short-prime-factors 39); '(3 13)

(short-prime-factors 540); '(2 3 5)

(short-prime-factors 1617); '(3 7 11)