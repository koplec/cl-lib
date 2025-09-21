# cl-lib


## testの動かし方

```lisp
(asdf:load-system :kplb :force t)
(ql:quickload :kplb/tests)

(asdf:test-system :kplb/tests)
```