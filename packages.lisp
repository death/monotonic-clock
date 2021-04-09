;;;; +----------------------------------------------------------------+
;;;; | Monotonic clock                                                |
;;;; +----------------------------------------------------------------+

;;;; Package definition

(defpackage #:monotonic-clock
  (:use #:cl)
  (:import-from
   #:cffi
   #:defcstruct
   #:foreign-funcall
   #:with-foreign-object
   #:with-foreign-slots)
  (:export
   #:monotonic-now
   #:monotonic-time-units-per-second
   #:monotonic-now/ms))
