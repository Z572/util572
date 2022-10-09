;;; Copyright (C) 2022 Zheng Junjie <873216071@qq.com>

(define-module (util572 box)
  #:use-module (ice-9 format)
  #:use-module (oop goops)
  #:export (<box> box-x box-y box-width box-height))

(define-class <box> ()
  (x #:init-value 0 #:init-keyword #:x #:accessor box-x)
  (y #:init-value 0 #:init-keyword #:y #:accessor box-y)
  (width #:init-value 0 #:init-keyword #:width #:accessor box-width)
  (height #:init-value 0 #:init-keyword #:height #:accessor box-height))

(define-method (equal? (box <box>) (box2 <box>))
  (and (= (box-x box) (box-x box2))
       (= (box-y box) (box-y box2))
       (= (box-width box) (box-width box2))
       (= (box-height box) (box-height box2))))

(define-method (write (box <box>) port)
  (format port "<~a ~x x:~a y:~a width:~a height:~a>"
          (class-name (class-of box))
          (object-address box)
          (box-x box)
          (box-y box)
          (box-width box)
          (box-height box)))
