;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; load-path set
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

;; init-loader
;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")
