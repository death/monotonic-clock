(in-package #:monotonic-clock)

;; https://msdn.microsoft.com/en-us/library/windows/desktop/ms724411%28v=vs.85%29.aspx

(defcfun ("GetTickCount64" get-tick-count-64) :uint64)

(declaim (inline monotonic-time-units-per-second))
(defun monotonic-time-units-per-second ()
  "Return the number of monotonic time units in one second.

The value returned should remain valid for the duration of the running
Lisp process, but no guarantee is made beyond this extent."
  1000)

(defun monotonic-now (&optional mode (include-suspend-p t))
  "Return the current monotonic time in monotonic time units.

MODE is ignored. The monotonic time is not affected by NTP.

If INCLUDE-SUSPEND-P is true, time spent while the system is suspended is
included. The default is true."
  (declare (ignore mode))
  (assert include-suspend-p (include-suspend-p)
          "Does not support INCLUDE-SUSPEND-P = false.")
  (get-tick-count-64))
