(require 'helm-config)
(helm-descbinds-mode)
(require 'helm-migemo)
(setq helm-use-migemo t)

; (require 'helm-c-moccur)
(require 'helm-elscreen)

;; key setting
(global-set-key (kbd "C-x b") 'helm-for-files)
(global-set-key (kbd "M-X") 'helm-M-x)

(define-key elscreen-map (kbd "b") 'helm-elscreen)
(define-key elscreen-map (kbd "B") 'helm-elscreen)
