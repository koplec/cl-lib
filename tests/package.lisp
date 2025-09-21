(defpackage :kplb/tests
  (:use :cl :fiveam)
  (:export :run-tests))

(in-package :kplb/tests)

(def-suite :kplb)
(in-suite :kplb)

(defun run-tests ()
  (run! :kplb))

