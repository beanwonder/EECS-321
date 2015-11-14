#lang plai/gc2/mutator
(allocator-setup "two-space-copying-gc.rkt" 200)
(define (build-one) (let* ((x0 #f)) x0))
(define (traverse-one x0) (if x0 #f #t))
(define (trigger-gc n)
  (if (zero? n) 0 (begin (cons n n) (trigger-gc (- n 1)))))
(define (loop i)
  (if (zero? i)
    'passed
    (let ((obj (build-one)))
      (trigger-gc 200)
      (if (traverse-one obj) (loop (- i 1)) 'failed))))
(loop 200)