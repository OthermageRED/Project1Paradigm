 #lang racket

 (define (main-loop)
   (display "> ")
   (define inp (read-line))
   (cond
     [(eof-object? inp) (void)]
     [else
      (displayln inp)
      (main-loop)]))

 (main-loop)
