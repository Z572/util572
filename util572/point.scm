(define-module (util572 point)
  #:use-module (oop goops)
  #:use-module (ice-9 format)
  #:duplicates (merge-accessors merge-generics replace warn-override-core warn last)
  #:export (<point>
            point-x
            point-y
            .x
            .y))

(define-class <point> ()
  (x #:init-value 0
     #:init-keyword #:x
     #:accessor .x)
  (y #:init-value 0
     #:init-keyword #:y
     #:accessor .y))

(define point-x .x)
(define point-y .y)

(define-method (write (point <point>) (port <port>))
  (format port "#<~a x: ~a y: ~a ~x>"
          (class-name (class-of point))
          (.x point)
          (.y point)
          (object-address point)))
