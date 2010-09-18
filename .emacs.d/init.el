;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq user-full-name "lapis25")
(setq user-mail-address "lapis25@gmail.com")

(set-language-environment 'Japanese)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)

;;; display

;;AntiAlias
(setq mac-allow-anti-aliasing t)

;;対応する括弧をハイライト
(show-paren-mode 1)

;; window
(tool-bar-mode -1)

;;bell消す
(setq ring-bell-function (lambda () ()))

;;; modeline
(progn
  (setq system-time-locale "English")
  (setq display-time-24hr-format t)
  (setq display-time-format "%Y-%m-%d(%a)%H:%M")
  (setq display-time-day-and-date t)
  (display-time-mode t))
(progn
  (line-number-mode t)
  (column-number-mode t)
  (setq frame-title-format "%b"))

;; auto-save-buffers setting
;;(auto-install-from-url "http://0xcc.net/misc/auto-save/auto-save-buffers.el")
(progn
  (require 'auto-save-buffers)
  (run-with-idle-timer 0.5 t 'auto-save-buffers)
  (define-key ctl-x-map "as" 'auto-save-buffers-toggle)
  )

;;; history
(setq history-length t)

;; elscreen
(require 'elscreen)
(load "elscreen-dired" "ElScreen-dired" t)
(load "elscreen-server" "ElScreen-server" t)

;;;kill-summary.el
;;;http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Programs/elisp/kill-summary.el
(autoload 'kill-summary "kill-summary" nil t)
(define-key global-map "\ey" 'kill-summary)

;;key setting for mac
(progn
  (global-set-key "\M-?" 'help-for-help)
  (global-set-key "\M-g" 'goto-line)
  (global-set-key "\C-h" 'backward-delete-char)
  (global-set-key [delete] 'delete-char))

(mac-key-mode 1)
(setq mac-option-modifier 'meta)
(fset 'yes-or-no-p 'y-or-n-p)

;; selection setting
(delete-selection-mode 1)
(pc-selection-mode)

;; indent setting
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))

  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  ;; cache setting
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1000)
  (setq migemo-coding-system 'utf-8-unix)
  (migemo-init))

;;; anything
;; (auto-install-batch "anything")

(require 'anything-config)
(setq anything-sources
      (list
       anything-c-source-elscreen
       anything-c-source-buffers+
       anything-c-source-file-name-history
       anything-c-source-files-in-current-dir+
       anything-c-source-recentf
       anything-c-source-complex-command-history
       anything-c-source-imenu
       anything-c-source-emacs-commands
       anything-c-source-emacs-functions
       ))

(global-set-key (kbd "C-;") 'anything)

(anything-iswitchb-setup)
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)

(when (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (ac-config-default))

;;; modes
;;dired-x
(load "dired-x")

;; ansi-term
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/zsh")

(add-hook 'ansi-term-after-hook
          (function
           (lambda ()
             (define-key term-raw-map "\C-t" 'shell-pop))))
(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

(global-set-key "\C-t" 'shell-pop)
(defvar ansi-term-after-hook nil)

;; cperl-mode
(progn
  (defalias 'perl-mode 'cperl-mode)
  (setq cperl-indent-level 4
        cperl-continued-statement-offset 4
        cperl-close-paren-offset -4
        cperl-font-lock t
        cperl-indent-parens-as-block t
        cperl-comment-column 32
        cperl-invalid-face nil
        cperl-tab-always-indent t
        cperl-highlight-variables-indiscriminately t
        )

  (add-hook 'cperl-mode-hook
            '(lambda ()
               (setq indent-tabs-mode nil)
               (turn-on-font-lock)
               ))
  
  ;; perl-completion
  (add-hook 'cperl-mode-hook
            (lambda()
              (require 'perl-completion)
              (perl-completion-mode t)))

  (add-hook  'cperl-mode-hook
             (lambda ()
               (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
                 (auto-complete-mode t)
                 (make-variable-buffer-local 'ac-sources)
                 (setq ac-sources
                       '(ac-source-perl-completion)))))

  (setq auto-mode-alist
  (append '(
            ("\\.pl$"   . cperl-mode)
            ("\\.pm$"   . cperl-mode)
            ("\\.perl$" . cperl-mode)
            ("\\.cgi$"  . cperl-mode)
            ("\\.psgi$" . cperl-mode)
            ) auto-mode-alist))
  )

;; font-lock setting
(setq font-lock-support-mode 'jit-lock-mode)
(global-font-lock-mode t)

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
