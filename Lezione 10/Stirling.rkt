;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Stirling) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define stirling ; valore: intero
  (lambda (n k) ; n, k > 0 interi, k in [1,n]
    (if (or (= k 1) (= k n))
        1
        (+ (stirling (- n 1) (- k 1))
           (* k (stirling (- n 1) k)))
        )
    ))

(stirling 3 2) ; 3

(stirling 6 3) ; 90

(stirling 6 4) ; 65

(stirling 6 6) ; 1

(stirling 9 5) ; 6951

(stirling 23 12) ; 1672162773483930