;;; Copyright (C) 2022, 2025 Zheng Junjie <z572@z572.online>
(define-module (util572 check)
  #:use-module (srfi srfi-34)
  #:use-module (srfi srfi-35)
  #:use-module ((system syntax)
                #:select (syntax-locally-bound-identifiers
                          syntax-module))
  #:export (&check-error
            check-error?
            check-error-checker
            check-error-value
            check-error-locally-bound-identifiers
            check-error-source
            check-error-file-name
            check-error-message
            check-error-line
            check-error-column
            define-check))

(define-condition-type &check-error &message
  check-error?
  (checker check-error-checker)
  (module check-error-module)
  (source check-error-source)
  (value check-error-value)
  (locally-bound-identifiers check-error-locally-bound-identifiers))

(define (check-error-file-name check-error)
  (assoc-ref (check-error-source check-error) 'filename))

(define (check-error-line check-error)
  (assoc-ref (check-error-source check-error) 'line))

(define (check-error-column check-error)
  (assoc-ref (check-error-source check-error) 'column))

(define check-error-message condition-message)

(define-syntax define-check
  (syntax-rules ()
    ((_ check-name proc
        #:message message*)
     (define-syntax check-name
       (lambda (y)
         (syntax-case y ()
           ((name obj #:message msg)
            (and (identifier? #'obj)
                 (string? (syntax->datum #'msg)))
            (let ((source (syntax-source y))
                  (module (syntax-module #'name))
                  (ides (syntax-locally-bound-identifiers #'name)))
              #`(let ((object obj))
                  (or (proc object)
                      (raise (condition
                              (&check-error
                               (checker (quote name))
                               (value object)
                               (source (quote #,(datum->syntax y source)))
                               (module (quote #,(datum->syntax #'name module)))
                               (locally-bound-identifiers
                                `(#,@(map (lambda (id) #`(#,id . ,#,id)) ides)))
                               (message msg))))))))
           ((name obj)
            #`(name obj #:message message*))))))
    ((define-check check-name proc message*)
     (define-check check-name proc #:message message*))))
