(el-get-bundle scala-mode2)
(el-get-bundle ensime/ensime-emacs
  :depends (s dash popup auto-complete scala-mode2 sbt-mode company-mode yasnippet)
  (autoload 'ensime-scala-mode-hook "ensime")
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

(autoload 'scala-mode "scala-mode2" nil t)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

(add-hook 'scala-mode-hook
          '(lambda ()
            (set (make-local-variable 'c-basic-offset) 2)))
