(in-package #:monotonic-clock)

;; https://developer.apple.com/library/content/qa/qa1398/_index.html

(defcfun ("mach_absolute_time" mach-absolute-time) :uint64)

(defcstruct mach-timebase-info
  (numer :uint32)
  (denom :uint32))

(defcfun ("mach_timebase_info" mach-timebase-info) :void
  (timebase-info :pointer))

(declaim (inline monotonic-time-units-per-second))
(defun monotonic-time-units-per-second ()
  "Return the number of monotonic time units in one second.

The value returned should remain valid for the duration of the running
Lisp process, but no guarantee is made beyond this extent."
  (load-time-value
   (with-foreign-object (ti '(:struct mach-timebase-info))
     (mach-timebase-info ti)
     (with-foreign-slots ((numer denom) ti (:struct mach-timebase-info))
       (truncate (* 1000000000 (/ numer denom)))))))

(defun monotonic-now (&optional mode include-suspend-p)
  "Return the current monotonic time in monotonic time units.

MODE is ignored. The monotonic time is not affected by NTP.

If INCLUDE-SUSPEND-P is true, time spent while the system is suspended is
included. The default is false."
  (declare (ignore mode))
  (assert (not include-suspend-p) (include-suspend-p)
          "Does not support INCLUDE-SUSPEND-P = true.")
  (mach-absolute-time))
