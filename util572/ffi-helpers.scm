(define-module (util572 ffi-helpers)
  #:export-syntax (define-make-ffi-procedure))
(define-syntax define-make-ffi-procedure
  (lambda (y)
    (syntax-case y ()
      ((_ f-name ->procedure)
       #'(define-syntax f-name
           (lambda (x)
             (with-ellipsis ___
               (syntax-case x ()
                 ((_ (name args ___) (return-type cname arg-types) body ___)
                  (with-syntax ((% (datum->syntax x '%)))
                    #'(begin
                        (define name
                          (let ((% (->procedure return-type cname arg-types)))
                            (lambda* (args ___)
                              body ___))))))
                 ((_ (name args ___) (return-type cname arg-types))
                  #'(f-name (name args ___) (return-type cname arg-types) (% args ___)))))))))))

;; Local Variables:
;; eval: (put 'with-ellipsis 'scheme-indent-function 1)
;; End:
