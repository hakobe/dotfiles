(add-to-list 'el-get-sources
    '(:name ensime
        :description "ENhanced Scala Interaction Mode for Emacs"
        :type github
        :pkgname "ensime/ensime-emacs"
        :depends (s dash popup auto-complete scala-mode2 sbt-mode company-mode yasnippet)
        :prepare (progn
                   (autoload 'ensime-scala-mode-hook "ensime")
                   (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))))


(el-get 'sync '(scala-mode2 ensime))

(autoload 'scala-mode "scala-mode2" nil t)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

(add-hook 'scala-mode-hook
          '(lambda ()
            (set (make-local-variable 'c-basic-offset) 2)))
