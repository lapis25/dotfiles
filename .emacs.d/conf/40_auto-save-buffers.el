;; auto-save-buffers setting
;;(auto-install-from-url "http://0xcc.net/misc/auto-save/auto-save-buffers.el")
(progn
  (require 'auto-save-buffers)
  (run-with-idle-timer 0.5 t 'auto-save-buffers)
  (define-key ctl-x-map "as" 'auto-save-buffers-toggle)
  )
