;; (auto-install-batch "auto-complete development version")

(when (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/install-lisp/ac-dict")
  (ac-config-default))
