# Monotonic clock

Provides a clock that returns nondecreasing values and is not affected
by (user-adjustable) system time.

## [Function] monotonic-now &optional mode include-suspend-p

Return the current monotonic time in monotonic time units.

If `mode` is `nil` (the default) the monotonic time is possibly
affected by NTP.  If it is `:raw`, effort is made to return a
monotonic time that is not affected by NTP.

If `include-suspend-p` is true, time spent while the system is suspended is
included. The default is platform dependent.

## [Function] monotonic-time-units-per-second

Return the number of monotonic time units in one second.

The value returned should remain valid for the duration of the running
Lisp process, but no guarantee is made beyond this extent.

## [Function] monotonic-now/ms &optional mode include-suspend-p

A convenience function to return the current monotonic time in
milliseconds.
