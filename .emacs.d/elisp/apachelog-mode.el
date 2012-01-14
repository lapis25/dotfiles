;; view mode for apache error log

(defface apachelog-error-face
  '((t :inherit font-lock-warning-face
       :foreground "white"
       :background "red"
       :bold t))
  "face for apachelog-mode error line")

(defvar apachelog-font-lock-keywords
  '(("^.*\\[error\\].*$"  . 'apachelog-error-face)
    ("^.*\\[notice\\].*$" . font-lock-comment-face))
  "apachelog keywords")

(defvar apachelog-mode-map ()
  "Keymap used in Apache ErrorLog mode.")

(when (not apachelog-mode-map)
  (setq apachelog-mode-map (make-sparse-keymap))
  (define-key apachelog-mode-map "K"
    (lambda ()
      (interactive)
      (kill-buffer (current-buffer))))
  (define-key apachelog-mode-map "k"
    (lambda ()
      (interactive)
      (switch-to-buffer (other-buffer)))))

(defun apachelog-mode ()
  "View mode for apache error_log"
  (interactive)
  (kill-all-local-variables)
  (set (make-local-variable 'font-lock-defaults)
       '(apachelog-font-lock-keywords t t))
  (use-local-map apachelog-mode-map)
  (setq mode-name "Apache ErrorLog"
        major-mode 'apachelog-mode)
  (run-hooks 'apachelog-mode-hook))

(provide 'apachelog-mode)
