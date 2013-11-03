(require 'flymake)
(require 'set-perl5lib)

(defun flymake-display-err-on-minibuffer ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no
          (flymake-current-line-no))
         (line-err-info-list
          (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count
          (length line-err-info-list))
         (messages))
    (while (> count 0)
      (let* ((info (nth (1- count) line-err-info-list))
             (file (flymake-ler-file info))
             (text (flymake-ler-text info))
             (line (flymake-ler-line info))
             (full-file (flymake-ler-full-file info)))
        (setq messages (cons (format "%d: %s" line text) messages)))
      (setq count (1- count)))
    (if (> (length messages) 0)
        (message "%s"
                 (mapconcat 'identity messages "\n")))))

(run-with-idle-timer 1 t 'flymake-display-err-on-minibuffer)

;; Perl用設定
;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (let ((mixi-root (mixi-dev-common-root (buffer-file-name))))
      (if mixi-root
          (list (format "%s/script/perl" mixi-root) (list "-wc" local-file))
        (list "perl" (list "-MProject::Libs lib_dirs => [qw(local/lib/perl5)]" "-wc" local-file))
        ))
))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 'flymake-perl-load)
