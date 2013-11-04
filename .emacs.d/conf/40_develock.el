; http://www.jpl.org/elips/develock.el.gz
(require 'develock nil t)

(if (featurep 'develock)
    (progn
      (setq develock-max-column-plist
            (list 'java-mode  90
                  'jde-mode   90
                  'emacs-lisp-mode 90
                  'lisp-interaction-mode 90
                  'html-mode  nil
                  'html-helper-mode nil
                  'cperl-mode 90
                  'perl-mode  90))
      (let ((elem (copy-sequence (assq 'message-mode develock-keywords-alist))))
        (setcar elem 'html-helper-mode)
        (setq develock-keywords-alist
              (cons elem (delq (assq 'html-helper-mode develock-keywords-alist)
                               develock-keywords-alist))))
