;;;; +----------------------------------------------------------------+
;;;; | Monotonic clock                                                |
;;;; +----------------------------------------------------------------+

(in-package #:monotonic-clock)

(include "time.h")

(ctype time-t "time_t")
(ctype clockid-t "clockid_t")

(constant (clock-monotonic "CLOCK_MONOTONIC"))
(constant (clock-monotonic-raw "CLOCK_MONOTONIC_RAW"))

;; For those who want to give up portability and use clock_gettime for
;; other purposes.
(constant (clock-realtime "CLOCK_REALTIME"))
(constant (clock-realtime-coarse "CLOCK_REALTIME_COARSE"))
(constant (clock-monotonic-coarse "CLOCK_MONOTONIC_COARSE"))
(constant (clock-boottime "CLOCK_BOOTTIME"))
(constant (clock-process-cputime-id "CLOCK_PROCESS_CPUTIME_ID"))
(constant (clock-thread-cputime-id "CLOCK_THREAD_CPUTIME_ID"))
