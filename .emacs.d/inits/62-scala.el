(el-get 'sync '(scala-mode2))

(add-hook 'scala-mode-hook
          '(lambda ()
            (set (make-local-variable 'c-basic-offset) 2)))