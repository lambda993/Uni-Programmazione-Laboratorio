;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define btr-sum
  (lambda (n1 n2)
       (if (nullo? (btr-carry-sum n1 n2 "."))
           "."
           (normalized-btr (btr-carry-sum n1 n2 "."))
           )
    ))

(define nullo?
  (lambda (n)
    (if (= (string-length n) 0)
        #true
        (if (not (string=? "." (substring n 0 1)))
            #false
            (nullo? (substring n 1))
            )
        )
    ))

(define btr-carry-sum
  (lambda (n1 n2 carry)
    (if (and (or (= (string-length n1) 0) (= (string-length n2) 0)) (string=? carry "."))
        (string-append (head (longest n1 n2))
                       (substring (btr-carry (lsd n1) (lsd n2) carry) 1))
        
        (string-append (btr-carry-sum (head n1) (head n2) (substring (btr-carry (lsd n1) (lsd n2) carry) 0 1))
                       (substring (btr-carry (lsd n1) (lsd n2) carry) 1))
        )
    ))

(define longest
  (lambda (n1 n2)
    (if (>= (string-length n1) (string-length n2))
        n1
        n2
        )
    ))

(define normalized-btr
  (lambda (n)
    (if (= (string-length n) 0)
        ""
        (if (string=? "." (substring n 0 1))
            (normalized-btr (substring n 1))
            n
            )
        )
    ))

(define lsd
  (lambda (n)
    (if (= (string-length n) 0)
        "."
        (substring n (- (string-length n) 1))
        )
    ))

(define head
  (lambda (n)
    (if (= (string-length n) 0)
        ""
        (substring n 0 (- (string-length n) 1))
        )
    ))

(define btr-carry
  (lambda (dig1 dig2 carry)
    (if (string=? carry "-")
        (cond
          ((and (string=? dig1 "-") (string=? dig2 "-"))
           "-.")
          ((and (string=? dig1 "-") (string=? dig2 "."))
           "-+")
          ((and (string=? dig1 "-") (string=? dig2 "+"))
           ".-")
          ((and (string=? dig1 ".") (string=? dig2 "-"))
           "-+")
          ((and (string=? dig1 ".") (string=? dig2 "."))
           ".-")
          ((and (string=? dig1 ".") (string=? dig2 "+"))
           "..")
          ((and (string=? dig1 "+") (string=? dig2 "-"))
           ".-")
          ((and (string=? dig1 "+") (string=? dig2 "."))
           "..")
          ((and (string=? dig1 "+") (string=? dig2 "+"))
           ".+")
          )
        (if (string=? carry ".")
            (cond
              ((and (string=? dig1 "-") (string=? dig2 "-"))
               "-+")
              ((and (string=? dig1 "-") (string=? dig2 "."))
               ".-")
              ((and (string=? dig1 "-") (string=? dig2 "+"))
               "..")
              ((and (string=? dig1 ".") (string=? dig2 "-"))
               ".-")
              ((and (string=? dig1 ".") (string=? dig2 "."))
               "..")
              ((and (string=? dig1 ".") (string=? dig2 "+"))
               ".+")
              ((and (string=? dig1 "+") (string=? dig2 "-"))
               "..")
              ((and (string=? dig1 "+") (string=? dig2 "."))
               ".+")
              ((and (string=? dig1 "+") (string=? dig2 "+"))
               "+-")
              )
            (if (string=? carry "+")
                (cond
                  ((and (string=? dig1 "-") (string=? dig2 "-"))
                   ".-")
                  ((and (string=? dig1 "-") (string=? dig2 "."))
                   "..")
                  ((and (string=? dig1 "-") (string=? dig2 "+"))
                   ".+")
                  ((and (string=? dig1 ".") (string=? dig2 "-"))
                   "..")
                  ((and (string=? dig1 ".") (string=? dig2 "."))
                   ".+")
                  ((and (string=? dig1 ".") (string=? dig2 "+"))
                   "+-")
                  ((and (string=? dig1 "+") (string=? dig2 "-"))
                   ".+")
                  ((and (string=? dig1 "+") (string=? dig2 "."))
                   "+-")
                  ((and (string=? dig1 "+") (string=? dig2 "+"))
                   "+.")
                  )
                ""
                )
            )
        )
    ))

(btr-sum "-+--" "+");"-+-."

(btr-sum "-+--" "-");"-.++"

(btr-sum "+-.+" "-+.-");"."

(btr-sum "-+--+" "-.--");"--++."

(btr-sum "-+-+." "-.-+");"-.-.+"

(btr-sum "+-+-." "+.+-");"+.+.-"
