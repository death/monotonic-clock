;;;; +----------------------------------------------------------------+
;;;; | Monotonic clock                                                |
;;;; +----------------------------------------------------------------+

(in-package #:monotonic-clock)

(unless (fboundp 'monotonic-now)
  (error "Monotonic clock is not implemented on this platform; patches welcome!"))

(defun monotonic-now/ms (&optional mode)
  "Return the current monotonic time in milliseconds."
  (values
   (floor (monotonic-now mode)
          ;; Assumes that the monotonic time unit is at least a
          ;; millisecond.  We're doing the calculation this way
          ;; because it's efficient.
          (floor (monotonic-time-units-per-second) 1000))))
