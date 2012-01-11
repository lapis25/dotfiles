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
        cperl-label-offset -4
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

(progn
  (autoload 'pod-mode "pod-mode" "Mode for editing POD files" t)
  (setq auto-mode-alist
        (append '(
                  ("\\.pod$" . pod-mode)
                  ) auto-mode-alist)))
(add-hook 'pod-mode-hook 'font-lock-mode))
