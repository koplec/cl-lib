(in-package :kplb)

(defun ensure-list (x)
  "If X is a list, return it; otherwise wrap X in a list."
  (if (listp x) x (list x)))

(defun print-hash-table (ht)
  (maphash (lambda (k v)
	     (format t "~A -> ~A~%" k v))
	   ht))

(defun line->integers (line)
  "文字列を空白で分割して整数のリストを返す"
  (with-input-from-string (stream line)
    (loop for token =  (read ;;空白文字ごとに読む
		       stream
		       nil ;; EOFになったら第3引数を返す
		       nil ;; 第3引数
		       )
	  while token
	  collect (parse-integer (princ-to-string token)))))


(defun rectangular-p (rows)
  "2次元配列のように縦横きれいに揃っているかの判定"
  (and rows
       (let ((w (length (first rows))))
	 (every (lambda (r) (= (length r) w)) (rest rows)))))


(defun list->2d-array (lst)
  (unless (rectangular-p lst)
    (error "list->2d-array: non-recgangular input ~S" lst))
  (let ((rows (length lst))
	(cols (length (first lst))))
    (make-array (list rows cols) :initial-contents lst)))

;;memorized
(defun memorize (fn &key (test #'equal) table)
  "最初の関数呼び出しをキャッシュしておく"
  (let ((cache (or table (make-hash-table :test test))))
    (labels ((self (&rest args)
	       (multiple-value-bind (value ok?) (gethash args cache)
		 (if ok?
		     (values-list value)
		     (let ((res (multiple-value-list (apply fn args))))
		       (setf (gethash args cache) res)
		       (values-list res))))))
      (values #'self cache))))

