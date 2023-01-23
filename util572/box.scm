;;; Copyright (C) 2022,2023 Zheng Junjie <873216071@qq.com>

(define-module (util572 box)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 format)
  #:use-module (srfi srfi-26)
  #:use-module (oop goops)
  #:use-module (util572 point)
  #:duplicates (merge-accessors merge-generics replace warn-override-core warn last)
  #:export (<box>
            box-x
            box-y
            box-left
            box-right
            box-top
            box-bottom
            box-width
            box-height
            box-empty?
            split-box
            split-box/n
            box-center
            box-center-point))

(define-class <box> ()
  (x #:init-value 0 #:init-keyword #:x #:accessor box-x)
  (y #:init-value 0 #:init-keyword #:y #:accessor box-y)
  (width #:init-value 0 #:init-keyword #:width #:accessor box-width)
  (height #:init-value 0 #:init-keyword #:height #:accessor box-height))

(define-method (initialize (object <box>) initargs)
  (let ((o (next-method)))
    (when (or (< (box-width o) 0)
              (< (box-height o) 0))
      (error "<box>' width and height must >= 0"))))

(define-method ((setter box-width) (box <box>) (i <integer>))
  (if (< i 0)
      (error "<box>' width must >= 0" i (current-source-location))
      (next-method)))

(define-method ((setter box-height) (box <box>) (i <integer>))
  (if (< i 0)
      (error "<box>' height must >= 0")
      (next-method)))

(define box-left box-x)
(define box-top box-y)

(define-method (box-right (box <box>))
  (+ (box-left box) (box-width box)))

(define-method (box-bottom (box <box>))
  (+ (box-top box) (box-height box)))

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

(define-method (box-empty? (box <box>))
  (any (cut <= <> 0) (list (box-width box) (box-height box))))

(define-method (split-box (box <box>) (n <number>) (x-or-y <symbol>))
  (define first-box (shallow-clone box))
  (define last-box (shallow-clone box))
  (case x-or-y
    ((x)
;;;  _____       _____
;;; |     |     |     |
;;; |     | => -+-----+-
;;; |     |     |     |
;;;  -----       -----
     (unless (<= n (box-height box))
       (error "n must <= (box-height box)"))
     (set! (box-height first-box) n)

     (set! (box-top last-box) (+ (box-top box) n))
     (set! (box-height last-box) (- (box-height box) n)))
    ((y)
;;;  _____      __|__
;;; |     |    |  |  |
;;; |     | => |  |  |
;;; |     |    |  |  |
;;;  -----      --|--
     (unless (<= n (box-width box))
       (error "n must <= (box-width box)"))
     (set! (box-width first-box) n)

     (set! (box-left last-box) (+ n (box-left box)))
     (set! (box-width last-box) (- (box-width box) n)))
    (else (error "X-OR-Y arg must 'x or 'y")))
  (list first-box last-box))

(define-method (split-box/n (box <box>) (n <number>) (x-or-y <symbol>))
  (define is-x? (eq? x-or-y 'x))
  (define get-w (if is-x? box-height box-width))
  (let loop ((nx (get-w box))
             (box box)
             (boxs '()))
    (if (<= (* 2 n) nx) ;; make sure last box don't too small.
        (let ((o (split-box box n x-or-y)))
          (loop (get-w (second o))
                (second o)
                (cons (first o) boxs)))
        (reverse (cons box boxs)))))

;; (define-method (split-box/fraction (box <box>) (n <fraction>) (x-or-y <symbol>))
;;   (define is-x? (eq? x-or-y 'x))
;;   (split-box box (round (* n ((if is-x? box-height box-width) box))) x-or-y))

(define-method (box-center (box <box>))
  (cons (+ (box-left box ) (/ (box-width box) 2))
        (+ (box-top box ) (/ (box-height box) 2))))

(define-method ((setter box-center) (box <box>) (p <pair>))
  (set! (box-left box) (- (car p) (/ (box-width box) 2)))
  (set! (box-top box) (- (cdr p) (/ (box-height box) 2))))

(define-method (box-center-point (box <box>))
  (let ((p (box-center box)))
    (make <point>
      #:x (car p)
      #:y (cdr p))))

(define-method ((setter box-center-point) (box <box>) (point <point>))
  (set! (box-left box) (- (point-x point ) (/ (box-width box) 2)))
  (set! (box-top box) (- (point-y point ) (/ (box-height box) 2))))
