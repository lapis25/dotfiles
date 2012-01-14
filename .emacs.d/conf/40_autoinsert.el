(setq auto-insert-directory "~/.emacs.d/template/")
(auto-insert-mode t)
(setq auto-insert-query nil)

(setq auto-insert-alist
      (append '(
                ("\\.pl$"   . "default.pl")
                ("\\.pm$"   . ["default.pm" my-template])
                ("\\.psgi$" . "default.psgi")
                ("\\.t$"    . "default.t")
                auto-insert-alist)))

(defvar template-replacements-alists
  '(("%module%" . (lambda()(perl-package-name)))))

(defmacro defreplace (name replace-string)
  `(defun ,name (str)
     (goto-char (point-min))
     (replace-string ,replace-string str)))

(require 'mixi-dev)

(defreplace my-template-module "%module%")
;; (defun module-name-from-path (file-name)
;;   (mixi-dev-common-root (file-name)))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
        (progn
          (goto-char (point-min))
          (replace-string (car c) (funcall (cdr c)) nil)))
    template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

(defun perl-package-name ()
  (let ((file-path (file-name-sans-extension (buffer-file-name))))
    (cond ((string-match "lib/" file-path)
           (replace-regexp-in-string "/" "::"
                                  (car (last (split-string file-path "/lib/")))))
          ((string-match "inc/" file-path)
           (replace-regexp-in-string "/" "::"
                                     (car (last (split-string file-path "/inc/")))))
          (file-name-nondirectory file-path))))
