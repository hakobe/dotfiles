(add-to-list 'el-get-sources
    '(:name flycheck
           :type github
           :pkgname "lunaryorn/flycheck"
           :description "On-the-fly syntax checking extension"
           :depends (s dash cl-lib f pkg-info)))

(el-get 'sync 'flycheck)

;; XXX flycheck-define-checker を呼べるようにするため
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
  :modes (perl-mode cperl-mode))
