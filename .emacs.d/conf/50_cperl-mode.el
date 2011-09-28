;;; cperl-mode
;; (auto-install-from-emacswiki "perl-completion.el")

(progn
  (defalias 'perl-mode 'cperl-mode)
  (setq cperl-indent-level 4
        cperl-continued-statement-offset 4
        cperl-close-paren-offset -4
        cperl-font-lock t
        cperl-indent-parens-as-block t
        cperl-comment-column 32
        cperl-invalid-face nil
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
            ("\\.psgi$" . cperl-mode)
            ) auto-mode-alist))
  )
