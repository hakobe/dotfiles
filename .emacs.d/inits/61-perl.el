(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.psgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("cpanfile$" . cperl-mode) auto-mode-alist))

(defun flycheck-perl-init ()
    (require 'flycheck)
    (require 'vc-git)

    (flycheck-define-checker perl-my-checker
      "A Perl syntax checker using customized checker at ~/.emacs.d/bim/perl_checker.pl"
      :command (
        (eval (expand-file-name "~/.emacs.d/libexec/perl_checker.pl"))
        (eval (expand-file-name (or (vc-git-root default-directory) ".")))
        source)
      :error-patterns
      ((error line-start (minimal-match (message))
              " at " (file-name) " line " line
              (or "." (and ", " (zero-or-more not-newline))) line-end))
      :modes (perl-mode cperl-mode)))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq cperl-close-paren-offset -4)
             (setq cperl-continued-statement-offset 4)
             (setq cperl-indent-level 4)
             (setq cperl-indent-parens-as-block t)
             (setq cperl-tab-always-indent t)
             (setq cperl-indent-parens-as-block t)
             (yas-minor-mode 1)
             (flycheck-perl-init)
             (flycheck-mode 1)
             (setq flycheck-checker 'perl-my-checker)))
