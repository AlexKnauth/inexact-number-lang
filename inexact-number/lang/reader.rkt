#lang racket/base

(provide (rename-out [-read read]
                     [-read-syntax read-syntax]
                     [-get-info get-info]))

(require racket/function
         syntax/module-reader
         "readtable.rkt")

;; [X ... -> Y] -> [X ... -> Y]
(define ((wrap-reader rd) . args)
  (parameterize ([current-readtable (extend-readtable (current-readtable))])
    (apply rd args)))

(define-values [-read -read-syntax -get-info]
  (make-meta-reader 'inexact-number
                    "language path"
                    lang-reader-module-paths
                    wrap-reader
                    wrap-reader
                    identity))

