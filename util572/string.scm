;;; Copyright (C) 2022 Zheng Junjie <873216071@qq.com>
(define-module (util572 string)
  #:export (string-split-length))

(define (string-split-length s length)
  (let loop ((s s))
    (if (> (string-length s ) length)
        (cons (string-take s length) (loop (string-drop s length)))
        (list s))))
