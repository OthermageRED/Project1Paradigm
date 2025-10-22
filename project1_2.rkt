 #lang racket

 (define (main-loop)
   (display "> ")
   (define inp (read-line))
   (cond
     [(eof-object? inp) (void)]
     [else
      (displayln inp)
      (main-loop)]))
;; Split a string on whitespace
(define (tokenize s)
  (filter (lambda (tok) (not (string=? tok "")))
          (regexp-split #px"\\s+" s)))
 (main-loop)
