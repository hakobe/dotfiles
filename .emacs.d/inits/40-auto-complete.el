(el-get-bundle auto-complete
  :post-init (progn
                (add-to-list 'ac-dictionary-directories
                              (expand-file-name "dict" default-directory))))
  (setq-default ac-sources
                '(ac-source-yasnippet ac-source-filename ac-source-words-in-buffer ac-source-words-in-same-mode-buffers ac-source-files-in-current-dir ac-source-dictionary ac-source-abbrev))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup) ;; elispの設定だけここにちょろっと書いとく

  (setq ac-auto-show-menu 0.3)
  (setq ac-use-menu-map t)

  (global-auto-complete-mode t)

  (with-eval-after-load-feature 'auto-complete
    (define-key ac-menu-map (kbd "\C-n") 'ac-next)
    (define-key ac-menu-map (kbd "\C-p") 'ac-previous)))
