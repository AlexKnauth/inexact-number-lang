#lang inexact-number racket

(module+ test
  (require rackunit)

  (check-pred inexact? 5)
  (check-pred inexact? 1/2)
  (check-equal? 5 5.0)
  (check-equal? 1/2 0.5)

  (check-pred inexact? 0)
  (check-pred inexact? -0)
  (check-equal? 0 0.0)
  (check-equal? -0 -0.0)

  (check-equal? (/ 0) +inf.0)
  (check-equal? (/ -0) -inf.0))

