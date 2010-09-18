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
