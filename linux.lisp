;;;; +----------------------------------------------------------------+
;;;; | Monotonic clock                                                |
;;;; +----------------------------------------------------------------+

(in-package #:monotonic-clock)

(defcstruct timespec
  (tv-sec time-t)
  (tv-nsec :long))

(declaim (inline clock-gettime))
(defun clock-gettime (clk-id)
  (with-foreign-object (ts '(:struct timespec))
    (unless (zerop (foreign-funcall "clock_gettime"
                                    clockid-t clk-id
                                    :pointer ts
                                    :int))
      ;; CFFI doesn't have a portable interface for errno at the
      ;; moment...
      (error "The function clock_gettime returned with an error."))
    (with-foreign-slots ((tv-sec tv-nsec) ts (:struct timespec))
      (values tv-sec tv-nsec))))

(declaim (inline monotonic-time-units-per-second))
(defun monotonic-time-units-per-second ()
  "Return the number of monotonic time units in one second.

The value returned should remain valid for the duration of the running
Lisp process, but no guarantee is made beyond this extent."
  1000000000)

(declaim (inline monotonic-now))
(defun monotonic-now (&optional mode)
  "Return the current monotonic time in monotonic time units.

If MODE is NIL (the default) the monotonic time is possibly affected
by NTP.  If it is :RAW, effort is made to return a monotonic time that
is not affected by NTP."
  (declare (optimize (speed 3)))
  (multiple-value-bind (sec nsec)
      (clock-gettime (ecase mode
                       ((nil) clock-monotonic)
                       ((:raw) clock-monotonic-raw)
                       ;; :COARSE is undocumented, but here for
                       ;; completeness.
                       ((:coarse) clock-monotonic-coarse)))
    (declare (type (unsigned-byte 32) sec) ;; 136 years seems OK to assume..
             (type (integer 0 (1000000000)) nsec))
    (+ (* sec (monotonic-time-units-per-second)) nsec)))
