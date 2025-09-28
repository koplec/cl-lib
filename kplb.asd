;; kplb.asd
(asdf:defsystem "kplb"
  :version "0.1.0"
  :author "koplec"
  :license "MIT"
  :description "koplec's persolan Lisp lib/lab"
  :depends-on (:alexandria)
  :serial t
  :components ((:file "src/package")
	       (:file "src/macros")
	       (:file "src/core")
	       (:file "src/test")
	       )
  )

(asdf:defsystem "kplb/tests"
  :depends-on (:kplb :fiveam)
  :serial t
  :components ((:file "tests/package")
	       (:file "tests/core-test"))
  :perform (asdf:test-op (o c)
		    (uiop:symbol-call :fiveam :run! :kplb)))
						    
