(el-get 'sync 'scala-mode2)
(autoload 'scala-mode "scala-mode2" nil t)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

(add-hook 'scala-mode-hook
          '(lambda ()
            (set (make-local-variable 'c-basic-offset) 2)))
