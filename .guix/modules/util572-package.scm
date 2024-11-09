(define-module (util572-package)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages texinfo)
  #:use-module (guix gexp)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages texinfo)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix packages))

(define-public util572
  (package
    (name "util572")
    (version "0")

    (source (local-file "../.." "util572-checkout"
                        #:recursive? #t
                        #:select? (or (git-predicate
                                       (string-append (current-source-directory)
                                                      "/../.."))
                                      (const #t))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:make-flags
      #~(list "GUILE_AUTO_COMPILE=0")))
    (native-inputs
     (list guile-3.0
           pkg-config
           autoconf
           automake
           texinfo))
    (inputs
     (list guile-3.0))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:gpl3+)))
util572
