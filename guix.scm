(use-modules
 ((guix licenses) #:prefix license:)
 (gnu packages guile)
 (gnu packages pkg-config)
 (gnu packages texinfo)
 (guix gexp)
 (guix build-system gnu)
 (gnu packages bash)
 (gnu packages)
 (gnu packages autotools)
 (gnu packages guile-xyz)
 (gnu packages pkg-config)
 (gnu packages texinfo)
 (guix git-download)
 (guix packages)
 (guix utils)
 (guix packages))
(define-public util572
  (package
    (name "util572")
    (version "0")

    (source (local-file "." "util572-checkout"
                        #:recursive? #t
                        #:select? (git-predicate (dirname (current-filename)))
                        ))
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
