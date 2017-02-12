;;;; +----------------------------------------------------------------+
;;;; | Monotonic clock                                                |
;;;; +----------------------------------------------------------------+

(in-package #:monotonic-clock)

(defcstruct timespec
  (tv-sec time-t)
  (tv-nsec :long))

(defcfun ("clock_gettime" %clock-gettime) :int
  (clk-id clockid-t)
  (tp :pointer))

(defun clock-gettime (clk-id)
  (with-foreign-object (ts '(:struct timespec))
    (unless (zerop (%clock-gettime clk-id ts))
      ;; CFFI doesn't have a portable interface for errno at the
      ;; moment...
      (error "The function clock_gettime returned with an error."))
    (with-foreign-slots ((tv-sec tv-nsec) ts (:struct timespec))
      (values tv-sec tv-nsec))))

(defconstant monotonic-time-units-per-second 1000000000
  "The number of monotonic time units in one second.")

(defun monotonic-now (&optional mode)
  "Return the current monotonic time in monotonic time units.

If MODE is NIL (the default) the monotonic time is possibly affected
by NTP.  If it is :RAW, effort is made to return a monotonic time that
is not affected by NTP."
  (multiple-value-bind (sec nsec)
      (clock-gettime (ecase mode
                       ((nil) clock-monotonic)
                       ((:raw) clock-monotonic-raw)
                       ;; :COARSE is undocumented, but here for
                       ;; completeness.
                       ((:coarse) clock-monotonic-coarse)))
    (+ (* sec monotonic-time-units-per-second) nsec)))
