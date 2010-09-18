;;;jaspace Japanese 2-byte whitespaces & tab visible
;;;http://homepage3.nifty.com/satomii/software/elisp.ja.html
(require 'jaspace)
(setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-highlight-tabs ?^)

(defface my-face-u-1
  '((t (:foreground "red" :background "pink" :underline t))) nil)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
