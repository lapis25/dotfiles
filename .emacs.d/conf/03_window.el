;;; display

;;対応する括弧をハイライト
(show-paren-mode 1)


;; window
(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'color-theme)
(color-theme-pok-wob)

;;bell消す
(setq ring-bell-function (lambda () ()))

;;; modeline
(progn
  (setq system-time-locale "English")
  (setq display-time-24hr-format t)
  (setq display-time-format "%Y-%m-%d(%a)%H:%M")
  (setq display-time-day-and-date t)
  (display-time-mode t)
  (line-number-mode t)
  (column-number-mode t)
  (setq frame-title-format "%b"))

;;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;; popwin
;;; (auto-install-from-url "https://raw.github.com/m2ym/popwin-el/v0.3/popwin.el")
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(push '("*compilation*" :position right :width 0.5 :noselect t) popwin:special-display-config)

;; 分割windowでも改行
(setq truncate-partial-width-windows nil)
