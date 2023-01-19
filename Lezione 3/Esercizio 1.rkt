;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define bin-rep->number
  (lambda (numero)
    (if (= (string-length numero) 0)
        0
        (if (positivo? numero)
            (+ (parte-intera (ottieni-intero numero)) (parte-decimale (ottieni-decimale numero)))
            (* -1 (+ (parte-intera (ottieni-intero numero)) (parte-decimale (ottieni-decimale numero))))
            )
        )
    ))

(define positivo?
  (lambda (numero)
    (not (string=? (substring numero 0 1) "-"))
    ))

(define posizione-punto
  (lambda (numero)
    (if (= (string-length numero) 0)
        0
        (if (string=? (substring numero 0 1) ".")
            0
            (+ 1 (posizione-punto (substring numero 1)))
            )
        )
    ))

(define ottieni-intero
  (lambda (numero)
    (if (or (string=? (substring numero 0 1) "+") (string=? (substring numero 0 1) "-"))
        (substring numero 1 (posizione-punto numero))
        (substring numero 0 (posizione-punto numero))
     )
    ))

(define ottieni-decimale
  (lambda (numero)
    (if (= (string-length numero) (posizione-punto numero))
        ""
        (substring numero (+ 1 (posizione-punto numero)))
        )
    ))

(define parte-intera
  (lambda (numero)
    (if (= (string-length numero) 0)
        0
        (+ (* (string->number (substring numero 0 1)) (expt 2 (- (string-length numero) 1))) (parte-intera (substring numero 1)))
     )
    ))

(define parte-decimale
  (lambda (numero)
    (if (= (string-length numero) 0)
        0
        (+ (* (string->number (substring numero (- (string-length numero) 1))) (expt 2 (* -1 (string-length numero))))
           (parte-decimale (substring numero 0 (- (string-length numero) 1))))
     )
    ))

(define rep->number
  (lambda (base numero)
    (if (= (string-length numero) 0)
        0
        (if (positivo? numero)
            (+ (parte-intera-b base (ottieni-intero numero)) (parte-decimale-b base (ottieni-decimale numero)))
            (* -1 (+ (parte-intera-b base (ottieni-intero numero)) (parte-decimale-b base (ottieni-decimale numero))))
            )
        )
    ))

(define valore-cifra
  (lambda (base numero)
    (if (string=? numero (substring base 0 1))
        0
        (+ 1 (valore-cifra (substring base 1) numero))
     )
    ))

(define parte-intera-b
  (lambda (base numero)
    (if (= (string-length numero) 0)
        0
        (+ (* (valore-cifra base (substring numero 0 1)) (expt (string-length base) (- (string-length numero) 1)))
           (parte-intera-b base (substring numero 1)))
     )
    ))

(define parte-decimale-b
  (lambda (base numero)
    (if (= (string-length numero) 0)
        0
        (+ (* (valore-cifra base (substring numero (- (string-length numero) 1))) (expt (string-length base) (* -1 (string-length numero))))
           (parte-decimale-b base (substring numero 0 (- (string-length numero) 1))))
        )
    ))

(bin-rep->number "+1101");13

(bin-rep->number "0");0

(bin-rep->number "10110.011");22.375

(bin-rep->number "-0.1101001");-0.8203125

(rep->number "zu" "-uuzz");-12

(rep->number "0123" "+21.1");9.25

(rep->number "01234" "-10.02");-5.08

(rep->number "0123456789ABCDEF" "0.A");0.625

(rep->number "0123456789ABCDEF" "1CF.0");463