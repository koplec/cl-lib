(in-package :kplb.test)

(defvar *tests* (make-array 0
			    :adjustable t
			    :fill-pointer 0))
;;ラン中の集計
(defvar *t-total* 0)
(defvar *t-passed* 0)

(defmacro deftest (name &body body)
  "REPLで(name)を直接呼べるテスト関数を定義し、登録する"
  `(progn
     (defun ,name () ,@body)
     ;;compile時は登録しない、ロード時、実行時にだけ登録
     (eval-when (:load-toplevel :execute) ;;
       ;;vector-push-extend -> pushして容量が足りなければ拡張
       ;;vectorのほうがランダムアクセスに強い
       (vector-push-extend (cons ',name #',name) *tests*)) 
     ',name))

(defun %report (pass form &optional (msg nil))
  (incf *t-total*)
  (when pass (incf *t-passed*))
  ;; ~@[ ~]は、対応する引数がNILでなければ、中身を出力する
  ;; ここでは、3番めのmsgが対応するので、msgがあるときだけ - <msg>が出力される
  (format t "~a ~a ~@[ - ~a~]~%"
	  (if pass "ok" "not ok") form msg))


(defmacro ok (expr &optional msg)
  `(let ((v ,expr))
     (%report (not (null v)) ',expr ,msg)))

(defmacro is (actual expected &optional msg)
  `(let* ((a ,actual)
	  (e ,expected)
	  (pass (equal a e)))
     (%report pass
	      '(is ,actual ,expected)
	      (if pass
		  ,msg
		  ;;テストが失敗したときにgot, expectedを出す
		  (format nil "got=~s expected=~s~@[ | ~a~]" a e ,msg)))))

(defun run-tests (&key pattern)
  "登録済みテストを実行。:patternで名前部分一致フィルタ可"
  (let ((total-tests 0)
	(failed-tests 0))
    (loop for (nm . fn) across *tests* do
      (when (or (null pattern)
		(search (string-upcase (princ-to-string pattern))
			(string-upcase (princ-to-string nm))))
	(incf total-tests)
	(let ((*t-total* 0)
	      (*t-passed* 0))
	  (handler-case (funcall fn)
	    (error (e)
	      (format t "not ok ~a - ERROR: ~a~%" nm e)))
	  (when (< *t-passed* *t-total*) (incf failed-tests))
	  )))
    (format t "~%Tests: ~a, Failed: ~a~%" total-tests failed-tests)
    (values (- total-tests failed-tests) total-tests)))


	    
				       
