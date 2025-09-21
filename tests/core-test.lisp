(in-package :kplb/tests)
(in-suite :kplb)

(test ensure-list
  (is (equal (kplb:ensure-list 1) '(1)))
      (is (equal (kplb:ensure-list '(1 2)) '(1 2))))



(test line->integers
  (is (equal (kplb:line->integers "1 2 3 4") '(1 2 3 4)))
  (is (equal (kplb:line->integers "01 02 03 04") '(1 2 3 4)))
  )


(test list->2d-array
  (let ((ary (kplb:list->2d-array '((1 2 3) (4 5 6)))))
    (is (equal (array-dimension ary 0) 2))
    (is (equal (array-dimension ary 1) 3))
    (is (equal (aref ary 0 0) 1))
    (is (equal (aref ary 0 1) 2))
    (is (equal (aref ary 0 2) 3))
    (is (equal (aref ary 1 0) 4))
    (is (equal (aref ary 1 1) 5))
    (is (equal (aref ary 1 2) 6))

    ))
