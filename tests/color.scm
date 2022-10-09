(define-module (tests color)
  #:use-module (util572 color)
  #:use-module (srfi srfi-64))

(test-group "make-rgba-color"
  (test-equal "number"
    (make-rgba-color 255 0 0 0)
    (make-rgba-color #xff000000))
  (test-equal "string"
    (make-rgba-color 255 0 0 0)
    (make-rgba-color "#ff000000"))
  (test-equal "short string"
    (make-rgba-color #xff000000)
    (make-rgba-color "#f000"))
  (test-equal "short string"
    (make-rgba-color #xff000000)
    (make-rgba-color "#f000"))
  (test-error "unmatch format string"
              #t
              (make-rgba-color "#f0000")))
