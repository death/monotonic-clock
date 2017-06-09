;;;; +----------------------------------------------------------------+
;;;; | Monotonic clock                                                |
;;;; +----------------------------------------------------------------+

(asdf:defsystem #:monotonic-clock
  :description "A nondecreasing clock that is not affected by user settings."
  :author "death <github.com/death>"
  :license "MIT"
  :defsystem-depends-on (#+(or linux darwin windows) #:cffi-grovel)
  :depends-on (#:cffi)
  :serial t
  :components
  ((:file "packages")
   #+linux (:cffi-grovel-file "linux-grovel")
   #+linux (:file "linux")
   #+darwin (:cffi-grovel-file "darwin-grovel")
   #+darwin (:file "darwin")
   #+windows (:cffi-grovel-file "windows-grovel")
   #+windows (:file "windows")
   (:file "convenience")))
