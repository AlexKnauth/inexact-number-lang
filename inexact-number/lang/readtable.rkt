#lang racket/base

(provide extend-readtable)

(require racket/port)
(module+ test
  (require rackunit))

;; Readtable -> Readtable
(define (extend-readtable orig-rt)
  ;; Char InputPort Any Nat Nat Nat -> Any
  (define (rt-proc char in src ln col pos)
    (define try-in (peeking-input-port in))
    (define try (read/recursive try-in char orig-rt))
    (cond
      [(number? try)
       ;; read it as if it had #i on the front
       (define prefix (string-append "#i" (string char)))
       (define inexact-in
         (input-port-append #f (open-input-string prefix) in))
       (read-syntax/recursive src inexact-in #f orig-rt)]
      [else
       ;; read normally
       (read-syntax/recursive src in char orig-rt)]))

  (make-readtable orig-rt
    #f 'non-terminating-macro rt-proc))

(module+ test
  (define rt (extend-readtable (current-readtable)))
  (check-equal? (parameterize ([current-readtable rt])
                  (read (open-input-string "-0")))
                -0.0))

