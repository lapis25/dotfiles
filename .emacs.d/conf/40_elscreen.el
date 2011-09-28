;;; elscreen
;; apel install
;; download from http://kanji.zinbun.kyoto-u.ac.jp/~tomo/elisp/APEL/
;; edit: APEL-CFG => APEL_PREFIX and EMU_PREFIX
;; run command: make install EMACS=/usr/bin/emacs PREFIX=$HOME/.emacs.d/install-lisp VERSION_SPECIFIC_LISPDIR=$HOME/.emacs.d/install-lisp LISPDIR=$HOME/.emacs.d/install-lisp

(require 'elscreen)
(load "elscreen-dired" "ElScreen-dired" t)
(load "elscreen-server" "ElScreen-server" t)
