(progn
  (require 'yaml-mode)
  (setq auto-mode-alist
        (append '
         (
          ("\\.yaml$"   . yaml-mode)
          ("\\.yml$"   . yaml-mode)
          ) auto-mode-alist)))
