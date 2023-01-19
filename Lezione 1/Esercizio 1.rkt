;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Esercizio 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define frase ; restituisce una stringa con la frase completa (aricolo + soggetto + verbo coniugato + articolo + complemento oggetto)
  (lambda (s pv co) ; argomenti: s = soggetto, pv = predicato verbale, co = complemento oggetto
    (string-append  (articolo s) " " s " " (verbo_coniugato s pv) " " (articolo co) " " co ".")
    ))

(define articolo ; restituisce l'articolo appropriato per il soggetto o il complemento oggetto
  (lambda (nome) ; argomento : nome = nome da cui estrarre i dati riguardante il genere e la quantità
    (let ( (ultimo_car (string-ref nome (- (string-length nome) 1)))
           )
      (if (char=? ultimo_car #\o)
          "il"
      (if (char=? ultimo_car #\i)
          "i"
          (if (char=? ultimo_car #\a)
              "la"
              (if (char=? ultimo_car #\e)
                  "le"
                  ""
                  )
              )
          )
      )
    )))

(define verbo_coniugato ; restituisce il vebo coniugato (are -> a, ano; ere -> e, ono; ire -> e, ono
  (lambda (s v) ; argomento: verbo alla forma infinita da coniugare; soggetto a cui applicare la quantità
    (let ( (coniugazione (string-ref v (- (string-length v) 3)))
           (pluralità (string-ref s (- (string-length s) 1)))
           )
           (if (and (char=? coniugazione #\a) (or (char=? pluralità #\a) (char=? pluralità #\o)))
               (string-append (substring v 0 (- (string-length v) 3)) "a")
               (if (and (char=? coniugazione #\a) (or (char=? pluralità #\e) (char=? pluralità #\i)))
               (string-append (substring v 0 (- (string-length v) 3)) "ano")
               (if (and (or (char=? coniugazione #\e) (char=? coniugazione #\i)) (or (char=? pluralità #\a) (char=? pluralità #\o)))
               (string-append (substring v 0 (- (string-length v) 3)) "e")
               (if (and (or (char=? coniugazione #\e) (char=? coniugazione #\i)) (or (char=? pluralità #\e) (char=? pluralità #\i)))
               (string-append (substring v 0 (- (string-length v) 3)) "ono")
               ""
               )))
               )
      )
    ))

(frase "gatto" "cacciare" "topi");"il gatto caccia i topi"

(frase "mucca" "mangiare" "fieno");"la mucca mangia il fieno"

(frase "sorelle" "leggere" "novella");"le sorelle leggono la novella"

(frase "bambini" "amare" "favole");"i bambini amano le favole"

(frase "musicisti" "suonare" "pianoforti");"i musicisti suonano i pianoforti"

(frase "cuoco" "friggere" "patate");"il cuoco frigge le patate"

(frase "camerieri" "servire" "clienti");"i camerieri servono i clienti"

(frase "mamma" "chiamare" "figlie");"la mamma chiama le figlie"