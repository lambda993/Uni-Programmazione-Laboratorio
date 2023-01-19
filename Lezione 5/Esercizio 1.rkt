;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define manhattan-3d
  (lambda (i j k)
    (if (or (and (= i 0) (= j 0) (= k 0))
            (and (= i 0) (= j 0))
            (and (= i 0) (= k 0))
            (and (= j 0) (= k 0)))
        1
        (cond ((= i 0)
              (manhattan-2d j k))
              ((= j 0)
              (manhattan-2d i k))
              ((= k 0)
              (manhattan-2d i j))
              (else (+ (manhattan-3d (- i 1) j k) (manhattan-3d i (- j 1) k) (manhattan-3d i j (- k 1))))
        )
        )
    ))

(define manhattan-2d
  (lambda (i j)
    (if (or (and (= i 0) (= j 0))
            (= i 0)
            (= j 0))
        1
        (+ (manhattan-2d (- i 1) j) (manhattan-2d i (- j 1)))
        )
    ))

(manhattan-3d 0 0 7);1

(manhattan-3d 2 0 2);6

(manhattan-3d 1 1 1);6

(manhattan-3d 1 1 5);42

(manhattan-3d 2 3 1);60

(manhattan-3d 2 3 3);560