
# :cl-cram
A simple, progress bar for Common Lisp like tqdm!

![demo](https://gyazo.com/3569d8645bcad63e139b380955d9bd37/raw)

## Usage

```lisp

;; in ./test.lisp

(load "cl-cram.lisp")
(use-package :cl-cram)

(defparameter x nil)
(defparameter y nil)
(defparameter z nil)

; You can line up several progress bars.
(init-progress-bar x "Loop1" 100000) ; register a new progress-bar.
(init-progress-bar y "Loop2" 100000)
(init-progress-bar z "Loop3" 100000)

(fresh-line)

(dotimes (_ 100000)
  (update x 1) ; update a progress-bar
  (update y 1)
  (update z 1))

(fresh-line)

(discard-all-progress-bar) ; reset all of progress-bars

(sleep 1)

; with-progress-macro is more simple way to display it!
(with-progress-bar x "Loop1" 100000
  (dotimes (i 100000)
    (update x 1)))

(fresh-line)
```

## Exports
```(init-progress-bar var desc total)```
Initialize the ProgressBar Structure and assign it to var.

desc: description of progress bar

total: max of the iteration

```(update status count)```
update the status, and display the new progress bar.

status: The structure to be updated as defined by the above macro

count: fixnum

```(discard-all-progress-bar)```
Abandon all lists of the progress bar 

```*progress-bar-ascii*```
You can set the character string as you want to be displayed as the meter. For example...

```(setq *progress-bar-ascii* "#")```

```*blank*```

exa.

```(setq *blank* " ")```

```*progress-bar-enabled*```
when `*progress-bar-enabled*` equals nil, no new line will be created.


```with-progress-bar```

Please see examples.
