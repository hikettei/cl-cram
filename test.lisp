
(load "cl-cram.lisp")

(use-package :cl-cram)

(init-progress-bar x "Loop1" 10000)
(init-progress-bar y "Loop2" 10000)
(init-progress-bar z "Loop3" 10000)

(fresh-line)

(dotimes (_ 10000)
  (update x 1)
  (update y 1)
  (update z 1))

(fresh-line)

(discard-all-progress-bar)

(sleep 1)

(with-progress-bar x "Loop1" 10000
  (dotimes (i 10000)
    (update x 1)))

(fresh-line)

