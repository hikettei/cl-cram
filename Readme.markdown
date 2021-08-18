
# cl-cram
A simple, progress bar for Common Lisp like tqdm!

![demo](https://gyazo.com/3569d8645bcad63e139b380955d9bd37/raw)

## Examples

```lisp

;; in ./test.lisp

(load "cl-cram.lisp")
(use-package :cl-cram)

(setq x nil)
(setq y nil)
(setq z nil)

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

