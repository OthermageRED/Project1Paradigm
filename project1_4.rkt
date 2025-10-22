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
(define (eval-tokens tokens)
  (cond
    [(null? tokens) "Invalid, needs tokens."]
    [(string->number (car tokens))
     => (lambda (n) n)]
    [else "Invalid, please rephrase."]))

 (main-loop)
