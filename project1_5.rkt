 #lang racket

 (define (main-loop)
   (display "> ")
   (define inp (read-line))
   (cond
     [(eof-object? inp) (void)]
     [else
      (define tokens (tokenize inp))
      (define result (eval-tokens tokens))
      (displayln result)
      (main-loop)]))
;; Split a string on whitespace
(define (tokenize s)
  (filter (lambda (tok) (not (string=? tok "")))
          (regexp-split #px"\\s+" s)))

;; Evaluate one-token numeric strings
(define (eval-expr tokens)
  (if (null? tokens)
      (values "Invalid, needs tokens." '())
      (let ([t (car tokens)]
            [rest (cdr tokens)])
        (cond
          [(equal? t "+")
           (define-values (a r1) (eval-expr rest))
           (define-values (b r2) (eval-expr r1))
           (if (or (string? a) (string? b))
               (values "Invalid, type two numbers after +" '())
               (values (+ a b) r2))]

          [(equal? t "*")
           (define-values (a r1) (eval-expr rest))
           (define-values (b r2) (eval-expr r1))
           (if (or (string? a) (string? b))
               (values "Invalid, type two numbers after *" '())
               (values (* a b) r2))]

          [(equal? t "/")
           (define-values (a r1) (eval-expr rest))
           (define-values (b r2) (eval-expr r1))
           (cond
             [(or (string? a) (string? b))
              (values "Invalid, type the dividend then the divisor after /." '())]
             [(zero? b)
              (values "Invalid, divide by zero." '())]
             [else (values (quotient a b) r2)])]

          [(string->number t)
           => (lambda (n) (values n rest))]

          [else (values "Invalid, please rephrase." '())]))))

(define (eval-tokens tokens)
  (define-values (result rest) (eval-expr tokens))
  (if (string? result)
      result
      (if (null? rest) result "Invalid, please rephrase.")))


 (main-loop)
