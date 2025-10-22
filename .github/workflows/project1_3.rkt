#lang racket

(define (tokenize str)
  (filter (lambda (s) (not (string=? s "")))
          (regexp-split #px"\\s+" str)))

(define (eval-expr tokens)
  (cond
    [(null? tokens) (values "Invalid, needs tokens." '())]
    [else (values (car tokens) (cdr tokens))]))

(define (eval-tokens tokens)
  (define-values (result remaining) (eval-expr tokens))
  (if (null? remaining)
      result
      "Invalid, please rephrase."))

(define (main-loop)
  (display "Enter input: ")
  (define input (read-line))
  (cond
    [(eof-object? input) (void)]
    [(string=? input "quit") (void)]
    [else
     (displayln (eval-tokens (tokenize input)))
     (main-loop)]))

(main-loop)
