
(load "cl-cram.lisp")

(use-package :cl-cram)

(defparameter x nil)
(defparameter y nil)
(defparameter z nil)

(init-progress-bar x "Loop1" 100000)
(init-progress-bar y "Loop2" 100000)
(init-progress-bar z "Loop3" 100000)

(fresh-line)

(dotimes (_ 100000)
  (update x 1)
  (update y 1)
  (update z 1))

(fresh-line)

(discard-all-progress-bar)

(sleep 1)
(with-progress-bar x "Loop1" 100000
  (dotimes (i 100000)
    (update x 1)))

(fresh-line)
