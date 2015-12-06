(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.psgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("cpanfile$" . cperl-mode) auto-mode-alist))

(defun run-perl-test ()
  "test実行します"
  (interactive)
  (compile (format "cd %s; carton exec -- perl %s" (vc-git-root default-directory) (buffer-file-name (current-buffer)))))

(defun run-perl-method-test ()
  (interactive)
  (let (
        (command compile-command)
        (test-method nil))
    (save-excursion
      (when (or
             (re-search-backward "\\bsub\s+\\([_[:alpha:]]+\\)\s*:\s*Test" nil t)
             (re-search-forward "\\bsub\s+\\([_[:alpha:]]+\\)\s*:\s*Test" nil t))
        (setq test-method (match-string 1))))
    (if test-method
        (compile (format "cd  %s; TEST_METHOD=%s carton exec -- perl %s"
                         (vc-git-root default-directory)
                         (shell-quote-argument test-method)
                         (buffer-file-name (current-buffer))))
      (let ((a 1))
        (save-excursion
          (when (or
                 (re-search-backward "^subtest\s+['\"]?\\([^'\"\s]+\\)['\"]?\s*=>\s*sub" nil t)
                 (re-search-foreward "^subtest\s+['\"]?\\([^'\"\s]+\\)['\"]?\s*=>\s*sub" nil t))
            (setq test-method (match-string 1))))
        (if test-method
            (compile (format "cd  %s; SUBTEST_FILTER=%s carton exec -- perl %s"
                             (vc-git-root default-directory)
                             (shell-quote-argument test-method)
                             (buffer-file-name (current-buffer)))))
        (message "not match")
        ))))


(defun flycheck-perl-init ()
    (require 'flycheck)
    (require 'vc-git)

    (flycheck-define-checker perl-my-checker
      "A Perl syntax checker using customized checker at ~/.emacs.d/bim/perl_checker.pl"
      :command (
        "~/.emacs.d/libexec/perl_checker.pl"
        (eval (expand-file-name (or (vc-git-root default-directory) ".")))
        source)
      :error-patterns
      ((error line-start (minimal-match (message))
              " at " (file-name) " line " line
              (or "." (and ", " (zero-or-more not-newline))) line-end))
      :modes (perl-mode cperl-mode)))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (set (make-local-variable 'indent-tabs-mode) nil)
             (set (make-local-variable 'cperl-close-paren-offset) -4)
             (set (make-local-variable 'cperl-continued-statement-offset) 4)
             (set (make-local-variable 'cperl-indent-level) 4)
             (set (make-local-variable 'cperl-indent-parens-as-block) t)
             (set (make-local-variable 'cperl-tab-always-indent) t)
             (set (make-local-variable 'cperl-indent-parens-as-block) t)
             (set (make-local-variable 'evil-shift-width) 4)

             (define-key cperl-mode-map [(super T)] 'run-perl-test)
             (define-key cperl-mode-map [(super t)] 'run-perl-method-test)

             (yas-minor-mode 1)
             (flycheck-perl-init)
             (flycheck-mode 1)
             (set (make-local-variable 'flycheck-checker) 'perl-my-checker)))
