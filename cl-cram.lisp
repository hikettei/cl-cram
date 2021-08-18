
(defpackage :cl-cram
  (:use :cl)
  (:export nil))

(in-package :cl-cram)

(defparameter *indent* 0)
(defparameter *number-of-bar* 0)

(defparameter *progress-bar* "█")
(defparameter *blank* "_")

(defstruct progress-bar-status
  (total)
  (count 0)
  (time)
  (desc)
  (line-pointer))

(defmacro backward-lines (n stream)
  `(progn (dotimes (_ ,n) (write-char #\Return ,stream))
	  (write-char #\Rubout ,stream)))

(defmacro init-progress-bar (var desc total)
  `(progn
     (incf *number-of-bar* 1)
     (setq *indent* (max (length ,desc) *indent*))
     (setq ,var (make-progress-bar-status :total ,total
					  :desc ,desc
				  	  :time 0))))

(defmacro progress-percent (status)
  `(fround (* 100 (/ (progress-bar-status-count ,status) (progress-bar-status-total ,status)))))

(defun update (status count)
  (incf (progress-bar-status-count status) count)
  (format t (render status)))

(defun render (status)
  (with-output-to-string (bar)
    (backward-lines *number-of-bar* bar)
    (let* ((desc (progress-bar-status-desc status))
	   (spl (- *indent* (length desc) -1)))
      (write-string desc bar)
      (dotimes (_ spl) (write-string " " bar))
      (write-string ":" bar))
    (write-string "|" bar)
    (let ((n (/ (round (fround (progress-percent status))) 10)))
      (dotimes (_ n) (write-string *progress-bar* bar))
      (dotimes (_ (- 10 n)) (write-string *blank* bar)))
    (write-string "|" bar)))

