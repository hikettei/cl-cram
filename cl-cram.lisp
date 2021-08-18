
(defpackage :cl-cram
  (:use :cl)
  (:export
   #:init-progress-bar
   #:update
   #:with-progress-bar
   #:discard-all-progress-bar
   #:*progress-bar-ascii*
   #:*blank*
   #:*progress-bar-enabled*))

(in-package :cl-cram)

(defparameter *indent* 0)
(defparameter *number-of-bar* 0)

(defparameter *progress-bar-enabled* t)
(defparameter *all-of-progress-bars* nil)

(defparameter *progress-bar-ascii* "█")
(defparameter *blank* "_")

(defstruct progress-bar-status
  (total)
  (count 0)
  (desc)
  (start-time)
  (nth-bar))

(defun backward-lines ()
  (write-char #\Return)
  (write-char #\Rubout))

(defmacro init-progress-bar (var desc total)
  `(progn
     (setq ,var (make-progress-bar-status :total ,total
					  :desc ,desc
					  :start-time (get-universal-time)
					  :nth-bar *number-of-bar*))
     (incf *number-of-bar* 1)
     (setq *indent* (max (length ,desc) *indent*))
     (setq *all-of-progress-bars* (concatenate 'list *all-of-progress-bars*
					       (list ,var)))
     ,var))

(defmacro discard-all-progress-bar ()
  (defparameter *all-of-progress-bars* nil)
  (defparameter *number-of-bar* 0))

(defmacro progress-percent (status)
  `(fround (* 100 (/ (progress-bar-status-count ,status) (progress-bar-status-total ,status)))))

(defun update (status count)
  (incf (progress-bar-status-count status) count)
  (backward-lines)
  (dolist (i *all-of-progress-bars*)
    (format t (render i))))

(defun render (status)
  (with-output-to-string (bar)
    (let* ((desc (progress-bar-status-desc status))
	   (spl (- *indent* (length desc) -1)))
      (write-string desc bar)
      (dotimes (_ spl) (write-string " " bar))
      (write-string ":" bar))
    (let* ((n (round (progress-percent status)))
	   (r (round (if (>= (/ n 10) 10) 10 (/ n 10)))))
      (if (< n 100)
	  (write-string " " bar))
      (write-string (write-to-string n) bar)
      (write-string "% |" bar)
      (dotimes (_ r) (write-string *progress-bar-ascii* bar))
      (dotimes (_ (- 10 r)) (write-string *blank* bar)))
    (write-string "| " bar)
    (write-string (write-to-string (progress-bar-status-count status)) bar)
    (write-string "/" bar)
    (write-string (write-to-string (progress-bar-status-total status)) bar)
    (write-string " [" bar)
    (let* ((now-time (get-universal-time))
	   (dif (- now-time (progress-bar-status-start-time status))))
      (write-string (write-to-string dif) bar)
      (write-string "s] " bar))))

(defmacro with-progress-bar (var desc total &body body)
  `(progn
     (init-progress-bar ,var ,desc ,total)
     ,@body
     (discard-all-progress-bar)))

