(define-module (util572 box)
  #:use-module (oop goops)
  #:export (<box> box-x box-y box-width box-height))

(define-class <box> ()
  (x #:init-keyword #:x #:accessor box-x)
  (y #:init-keyword #:y #:accessor box-y)
  (width #:init-keyword #:width #:accessor box-width)
  (height #:init-keyword #:height #:accessor box-height))
