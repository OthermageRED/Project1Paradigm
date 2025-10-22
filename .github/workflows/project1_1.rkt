#lang racket

(define (main-loop)
  (display "Enter input: ")
  (define input (read-line))
  (cond
    [(eof-object? input) (void)]
    [(string=? input "quit") (void)]
    [else
     (displayln input)
     (main-loop)]))

(main-loop)
