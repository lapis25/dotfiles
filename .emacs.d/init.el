;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; load-path set
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/install-lisp"))

;; package.el
;;; (auto-install-from-url "http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el")
;;; (progn (switch-to-buffer (url-retrieve-synchronously "https://raw.github.com/milkypostman/melpa/master/melpa.el")) (package-install-from-buffer  (package-buffer-info) 'single))

(when (require 'package nil t)
  ;; パッケージリポジトリにMarmaladeを追加
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("ELPA"      . "http://tromey.com/elpa/"))
  ;; インストールしたパッケージにロードパスを通してロードする
  (package-initialize))

; melpa.el
(require 'melpa)

(require 'cl)
(defvar installing-package-list
  '(
    ac-helm
    ack
    anything
    auto-complete
    color-theme
    elscreen
    eproject
    exec-path-from-shell
    gtags
    helm
    helm-ack
    helm-c-yasnippet
    helm-descbinds
    helm-gtags
    helm-migemo
    init-loader
    magit
    markdown-mode
    markdown-mode+
    melpa
    migemo
    multi-term
    perl-completion
    pod-mode
    popup
    popwin
    shell-pop
    yaml-mode
    ))

(let ((not-installed (loop for x in installing-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

;; init-loader
;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")

;; system-type
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
      linux-p   (eq system-type 'gnu/linux)
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      meadow-p  (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))
