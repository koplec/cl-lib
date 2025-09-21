(in-package :kplb/tests)
(in-suite :kplb)

(test ensure-list
  (is (equal (kplb:ensure-list 1) '(1)))
      (is (equal (kplb:ensure-list '(1 2)) '(1 2))))

(test hello-test
  (is (equal (kplb:hello "tom") "tom")))


