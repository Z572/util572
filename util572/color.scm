;;; Copyright (C) 2022 Zheng Junjie <873216071@qq.com>
(define-module (util572 color)
  #:use-module (util572 string)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match)
  #:use-module (ice-9 format)
  #:use-module (oop goops)
  #:use-module (system foreign)
  #:export (make-rgba-color <rgba-color>))

(define-class <color> ())
(define-class <rgba-color> (<color>)
  (r #:init-keyword #:r #:accessor color-r)
  (g #:init-keyword #:g #:accessor color-g)
  (b #:init-keyword #:b #:accessor color-b)
  (a #:init-keyword #:a #:accessor color-a))

(define-method (make-rgba-color r g b a)
  (make <rgba-color> #:r r #:g g #:b b #:a a))

(define-method (make-rgba-color (color <integer>))
  (make-rgba-color (string-append "#" (number->string color 16))))

(define-method (make-rgba-color (color <string>))
  (define (color-error o)
    (error (format #f "must be like '#rrggbbaa' or '#rgba', but get '~S'" o)))
  (if (string-prefix? "#" color)
      (let ((s (substring color 1)))
        (case (string-length s)
          ((8) (apply make-rgba-color
                      (map (cut string->number <> 16)
                           (string-split-length s 2))))
          ((4) (apply make-rgba-color
                      (map (lambda (o)
                             (string->number (string-append o o) 16))
                           (string-split-length s 1))))
          (else (color-error color))))
      (color-error color)))

(define-method (write (color <rgba-color>) port)
  (format port "<~a ~x r: ~a g: ~a b: ~a a: ~a>"
          (class-name (class-of color))
          (object-address color)
          (color-r color)
          (color-g color)
          (color-b color)
          (color-a color)))

(define-method (equal? (color <rgba-color>) (color2 <rgba-color>))
  (and (equal? (color-r color) (color-r color2))
       (equal? (color-g color) (color-g color2))
       (equal? (color-g color) (color-g color2))
       (equal? (color-a color) (color-a color2))))
