;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 2|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define codice-cesare-3
  (lambda (testo regola)
    (if (= (string-length testo) 0)
        ""
        (if (not (appartiene (substring testo 0 1) alfabeto))
            (string-append (substring testo 0 1) (codice-cesare-3 (substring testo 1) regola))
            (string-append (regola (substring testo 0 1) 3) (codice-cesare-3 (substring testo 1) regola))
            )
        )
    ))

(define codice-cesare-17
  (lambda (testo regola)
    (if (= (string-length testo) 0)
        ""
        (if (not (appartiene (substring testo 0 1) alfabeto))
            (string-append (substring testo 0 1) (codice-cesare-17 (substring testo 1) regola))
            (string-append (regola (substring testo 0 1) 17) (codice-cesare-17 (substring testo 1) regola))
            )
        )
    ))

(define alfabeto "ABCDEFGHILMNOPQRSTVX")

(define chiave
  (lambda (lettera n)
    (if (>= (+ (posizione lettera alfabeto) n) (string-length alfabeto))
        (string (string-ref alfabeto (- (+ (posizione lettera alfabeto) n) (string-length alfabeto))))
        (string (string-ref alfabeto (+ (posizione lettera alfabeto) n)))
        )
    ))

(define appartiene
  (lambda (lettera caratteri)
    (if (= (string-length caratteri) 0)
        #false
        (if (string=? lettera (substring caratteri 0 1))
            #true
            (appartiene lettera (substring caratteri 1))
            )
        )
    ))

(define posizione
  (lambda (lettera alfab)
    (if (string=? lettera (substring alfab 0 1))
        0
        (+ 1 (posizione lettera (substring alfab 1)))
        )
    ))

; ABCDEFGHILMNOPQRSTVX

(codice-cesare-3 "ALEA IACTA EST IVLIVS CAESAR DIXIT" chiave); "DOHD NDFAD HXA NBONBX FDHXDV GNCNA" (chiave = 3)

(codice-cesare-17 "DOHD NDFAD HXA NBONBX FDHXDV GNCNA" chiave); "ALEA IACTA EST IVLIVS CAESAR DIXIT" (chiave = 17)

(define succ
  (lambda (v)
    (+ v 1)
    ))

(define add
  (lambda (m n)
    (if (= n 0)
        m
        (succ (add m (- n 1)))
        )
    ))

(define mul
  (lambda (m n)
    (if (= n 0)
        0
        (add m (mul m (- n 1)))
        )
    ))

(define pow
  (lambda (m n)
    (if (= n 0)
        1
        (mul m (pow m (- n 1)))
        )
    ))

(define H
  (lambda (f g)
    (lambda (m n)
      (if (= n 0)
          (f m)
          (g m ((H f g) m (- n 1)))
          )
      )
    ))

(define s2
  (lambda (u v)
    (+ v 1)
    ))

(define add2
  (H (lambda (x) x) s2)
  )

(define mul2
  (H (lambda (x) 0) add2)
  )

(define pow2
  (H (lambda (x) 1) mul2)
  )

(add 5 0)

(add2 5 0)

(add 5 6)

(add2 5 6)

(mul 5 0)

(mul2 5 0)

(mul 5 6)

(mul2 5 6)

(pow 5 0)

(pow2 5 0)

(pow 5 6)

(pow2 5 6)