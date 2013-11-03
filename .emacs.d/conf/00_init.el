(setq user-full-name "lapis25")
(setq user-mail-address "lapis25@gmail.com")

;; lanuage
(set-language-environment 'Japanese)

;; utf-8 優先
(prefer-coding-system 'utf-8)

;; 起動時のメッセージ非表示
(setq inhibit-startup-message t)

;; backupfileをつくらない
(setq backup-inhibited nil)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; indent setting
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;;; history
(savehist-mode 1)
(setq history-length 10000)
(setq recentf-max-saved-items 1000)

;; selection setting
(delete-selection-mode 1)
;(pc-selection-mode)

;; gc setting
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; completion
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(icomplete-mode 1)

;; command
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; path setting
(exec-path-from-shell-initialize)

; server start for emacs-client
(require 'server)
(unless (server-running-p)
    (server-start))
