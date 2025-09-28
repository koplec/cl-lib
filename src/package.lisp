(defpackage :kplb
  (:nicknames :kp)
  (:use :cl)
  (:export

   ;;core.lisp
   
   :ensure-list
   :print-hash-table
   :line->integers
   :list->2d-array
   :memorize
   :memorizef

   ;;macros.lisp
   :with-gensyms :defun-typed :while
   ))

(defpackage :kplb.test
  (:use :cl) ;;common-lisp標準パッケージ利用
  (:export :deftest :ok :is :run-tests ))

