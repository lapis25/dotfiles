;;key setting for mac
(progn
  (global-set-key "\M-?" 'help-for-help)
  (global-set-key "\M-g" 'goto-line)
  (global-set-key "\C-h" 'backward-delete-char)
  (global-set-key [delete] 'delete-char))

(mac-key-mode 1)
(setq mac-option-modifier 'meta)
(fset 'yes-or-no-p 'y-or-n-p)
