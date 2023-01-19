;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define match
  (lambda (u v)
    (if (or (string=? u "") (string=? v ""))
        ""
        (let ( (uh (string-ref u 0)) (vh (string-ref v 0))
              (s (match (substring u 1) (substring v 1)))
              )
          (if (char=? uh vh)
              (string-append (string uh) s)
              (string-append "*" s)
              ))
    )))

(match "astrazione" "estremi"); "*str**i"

(define offset (char->integer #\0))

(define last-digit
  (lambda (base) (integer->char (+ (- base 1) offset)) ))

(define next-digit
  (lambda (dgt) (string (integer->char (+ (char->integer dgt) 1))) ))

(define increment
  (lambda (num base)
    (let ((digits (string-length num)))
      (if (= digits 0)
          "1"
          (let ((dgt (string-ref num (- digits 1))))
            (if (char=? dgt (last-digit base))
                (string-append (increment (substring num 0 (- digits 1)) base) "0")
                (string-append (substring num 0 (- digits 1)) (next-digit dgt))
                ))
          ))))

(increment "1011" 2); "1100"

(define cyclic-string
  (lambda (str n)
    (if (or (= (string-length str) 0) (<= n 0))
        ""
        (if (<= n (string-length str))
            (substring str 0 n)
            (string-append str (cyclic-string str (- n (string-length str))))
            )
        )
    ))

(cyclic-string "abcd" 0); ""

(cyclic-string "abcd" 1); "a"

(cyclic-string "abcd" 2); "ab"

(cyclic-string "abcd" 4); "abcd"

(cyclic-string "abcd" 5); "abcda"

(cyclic-string "abcd" 11); "abcdabcdabc"

(define av
  (lambda (lista)
    (if (<= (length lista) 1)
        null
        (append (list (risultato-insieme (list-ref lista 0) (list-ref lista 1))) (av (cdr lista)))
        )
    ))

(define risultato-insieme
  (lambda (n1 n2)
    (if (< (+ n1 n2) 0)
        -1
        (if (> (+ n1 n2) 0)
            1
            0
            )
        )
    ))

(av '(0 0 -1 -1 1 0 0 1 0)); (0 -1 -1 0 1 0 1 1)

(define perfect
  (lambda (n)
    (if (= (somma-divisori (divisori-diversi n 1)) n)
        (divisori-diversi n 1)
        null
        )
    ))

(define somma-divisori
  (lambda (lista)
    (if (= (length lista) 0)
        0
        (+ (car lista) (somma-divisori (cdr lista)))
        )
    ))

(define divisori-diversi
  (lambda (n divisore)
    (if (= divisore (- n 1))
        null
        (if (= (modulo n divisore) 0)
            (append (list divisore) (divisori-diversi n (+ divisore 1)))
            (divisori-diversi n (+ divisore 1))
            )
        )
    ))

(perfect 28); (list 1 2 4 7 14) somma = 28

(perfect 27); (list) somma = 13

(define r-val
  (lambda (n)
    (if (string=? n ".")
        0
        (+ (* (string->number (lsd n)) (expt 2 (- 0 (- (string-length n) 1)))) (r-val (substring n 0 (- (string-length n) 1))))
        )
    ))

(define lsd
  (lambda (n)
    (if (= (string-length n) 0)
        ""
        (substring n (- (string-length n) 1))
        )
    ))

(r-val ".1"); 0.5

(r-val ".011"); 0.375

(define shared
  (lambda (l1 l2)
    (if (= (length l1) 0)
        null
        (if (appartiene (car l1) l2)
            (append (list (car l1)) (shared (cdr l1) l2))
            (shared (cdr l1) l2)
            )
        )
    ))

(define appartiene
  (lambda (n lista)
    (if (= (length lista) 0)
        #false
        (if (= n (car lista))
            #true
            (appartiene n (cdr lista))
            )
        )
    ))

(shared '(1 3 5 6 7 8 9 10) '(0 1 2 3 4 5 7 9)); (1 3 5 7 9)

(define split
  (lambda (lista)
    (if (= (length lista) 0)
        null
        (list (genera-pari lista) (genera-dispari lista))
        )
    ))

(define genera-pari
  (lambda (lista)
    (if (= (length lista) 0)
        null
        (if (= (modulo (car lista) 2) 0)
            (append (list (car lista)) (genera-pari (cdr lista)))
            (genera-pari (cdr lista))
            )
        )
    ))

(define genera-dispari
  (lambda (lista)
    (if (= (length lista) 0)
        null
        (if (not (= (modulo (car lista) 2) 0))
            (append (list (car lista)) (genera-dispari (cdr lista)))
            (genera-dispari (cdr lista))
            )
        )
    ))

(split '(3 5 8 7 4 4 1 5 2 6)); '((8 4 4 2 6) (3 5 7 1 5))