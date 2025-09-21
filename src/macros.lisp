(in-package :kplb)

(defmacro with-gensyms (names &body body)
  "Bind each symbol in NAMES to a fresh gensym, then eval BODY"
  `(let ,(mapcar (lambda (name)
		   `(,name (gensym ,(string name))))
	  names)
     ,@body))


(defmacro defun-typed (name (arg-types ret-types)
			    args
		       &body body)
  `(progn
     (declaim (ftype (function ,arg-types ,ret-types) ,name))
     (defun ,name ,args ,@body)))

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))
