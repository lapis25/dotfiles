;;; cperl-mode
;; (auto-install-from-emacswiki "perl-completion.el")

(progn
  (defalias 'perl-mode 'cperl-mode)
  (setq cperl-indent-level 4
        cperl-continued-statement-offset 4
        cperl-continuted-statement-offset 0;
        cperl-close-paren-offset -4
        ;cperl-font-lock t
        cperl-indent-parens-as-block t
        cperl-indent-region-fix-constructs nil;
        cperl-indent-subs-specially nil;
        cperl-comment-column 40
        cperl-label-offset nil
        ;cperl-invalid-face nil
        cperl-invalid-face (quote default);
        ;cperl-lazy-help-time 0;
        cperl-merge-trailing-else nil;
        cperl-under-as-char nil;
        cperl-tab-always-indent t
        cperl-highlight-variables-indiscriminately t
        )

  (add-hook 'cperl-mode-hook
            '(lambda ()
               (setq indent-tabs-mode nil)
               (turn-on-font-lock)
               ))
  ;; (auto-install-from-url http://coderepos.org/share/export/39208/lang/elisp/set-perl5lib/set-perl5lib.el)
  (require 'set-perl5lib)

  ;; perl-completion
  (add-hook 'cperl-mode-hook
            (lambda()
              (require 'perl-completion)
              (perl-completion-mode t)))

  (add-hook  'cperl-mode-hook
             (lambda ()
               (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
                 (auto-complete-mode t)
                 (make-variable-buffer-local 'ac-sources)
                 (setq ac-sources
                       '(ac-source-perl-completion)))))

  (setq auto-mode-alist
        (append '(
                  ("\\.pl$"   . cperl-mode)
                  ("\\.pm$"   . cperl-mode)
                  ("\\.perl$" . cperl-mode)
                  ("\\.cgi$"  . cperl-mode)
                  ("\\.t$"    . cperl-mode)
                  ("\\.xt$"   . cperl-mode)
                  ("\\.psgi$" . cperl-mode)
                  ) auto-mode-alist))

  (progn
    (defun perltidy-region ()
      "Run perltidy on the current region."
      (interactive)
      (save-excursion
        ;(shell-command-on-region (point) (mark) "perltidy -q" nil t)))
        (shell-command-on-region (point) (mark) "PERL5LIB=$HOME/local/lib/perl5 $HOME/local/bin/perltidy -q" nil t)))
    (defun perltidy-defun ()
      "Run perltidy on the current defun."
      (interactive)
      (save-excursion (mark-defun)
                      (perltidy-region)))))

;; run-test
(defun perl-run-test ()
  "run test"
  (interactive)
  (compile
   (format "cd  %s; %s -Mlocal::lib=./local -It/inc -Ilib -Iinc %s"
           (replace-regexp-in-string
            "\n+$" ""
            (shell-command-to-string "git rev-parse --show-cdup"))
           (expand-file-name "/usr/local/perl-5.14.4/bin/perl")
           (buffer-file-name (current-buffer)))))

(add-hook 'cperl-mode-hook
          '(lambda()
             (progn
               (define-key cperl-mode-map (kbd "C-c t") 'perl-run-test)
               (define-key cperl-mode-map (kbd "C-c C-t") 'perl-run-test))))

(progn
  (autoload 'pod-mode "pod-mode" "Mode for editing POD files" t)
  (setq auto-mode-alist
        (append '(
                  ("\\.pod$" . pod-mode)
                  ) auto-mode-alist)))
(add-hook 'pod-mode-hook 'font-lock-mode))
