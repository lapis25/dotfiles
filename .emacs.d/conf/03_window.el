;;; display

;;対応する括弧をハイライト
(show-paren-mode 1)

;; 現在行に色を付ける
(global-hl-line-mode t)

;; window
(tool-bar-mode -1)
(scroll-bar-mode -1)

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
