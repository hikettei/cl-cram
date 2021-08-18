
(load "cl-cram.lisp")

(sb-profile:profile "CL-CRAM")
(use-package :cl-cram)

(defparameter x nil)
(defparameter y nil)
(defparameter z nil)

(init-progress-bar x "Loop1" 9000000)
(init-progress-bar y "Loop2" 9000000)
(init-progress-bar z "Loop3" 9000000)

(fresh-line)

(dotimes (_ 900000)
  (update x 1)
  (update y 1)
  (update z 1))

(fresh-line)

(discard-all-progress-bar)

(sleep 1)

(with-progress-bar x "Loop1" 9000000
  (dotimes (i 9000000)
    (update x 1)))

(fresh-line)

(sb-profile:report)

