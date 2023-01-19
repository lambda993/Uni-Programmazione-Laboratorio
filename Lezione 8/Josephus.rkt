;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Josephus) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))

;; Conta ispirata a un racconto di Giuseppe Flavio
;;
;; Ultimo aggiornamento: 8/03/12


;; Dato astratto "configurazione" della tavola rotonda, inclusi i cavalieri
;;
;; Protocollo:
;;
;;   (new-round-table n)           :  interi -> configurazioni
;;
;;   (last-knight-in? tab)         :  configurazioni -> booleani
;;
;;   (knight-with-jug-in tab)      :  configurazioni -> etichette [interi]
;;
;;   (after-next-exit-from tab)    :  configurazioni -> configurazioni


(define josephus                   ; val: etichetta [intero]
  (lambda (n)                      ; n: intero positivo
    (count (new-round-table n))
    ))

(define count                      ; val: etichetta
  (lambda (tab)                    ; tab: configurazione
    (if (last-knight-in? tab)
        (knight-with-jug-in tab)
        (count (after-next-exit-from tab))
        )
    ))


;; I Realizzazione del dato astratto "tavola rotonda"


;; n cavalieri attorno alla tavola rotonda

(define new-round-table            ; val: configurazione
  (lambda (n)                      ; n: intero positivo
    (subrange 1 n)
    ))

;; ultimo cavaliere

(define last-knight-in?            ; val: booleano
  (lambda (tab)                    ; tab: configurazione
    (null? (cdr tab))
    ))

(define knight-with-jug-in car)    ; cavaliere con la brocca

;; un cavaliere viene servito e la brocca passa al successivo

(define after-next-exit-from       ; val: configurazione
  (lambda (tab)                    ; tab: configurazione
    (append (cddr tab) (list (car tab)))
    ))


;; procedura di supporto: intervallo di interi da inf a sup

(define subrange                   ; val: lista di interi
  (lambda (inf sup)                ; inf, sup: interi
    (if (> inf sup)
        null
        (cons inf (subrange (+ inf 1) sup))
        )
    ))
