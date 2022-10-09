(define-module (util572 box)
  #:use-module (oop goops)
  #:export (<box> box-x box-y box-width box-height))

(define-class <box> ()
  (x #:init-value 0 #:init-keyword #:x #:accessor box-x)
  (y #:init-value 0 #:init-keyword #:y #:accessor box-y)
  (width #:init-value 0 #:init-keyword #:width #:accessor box-width)
  (height #:init-value 0 #:init-keyword #:height #:accessor box-height))
