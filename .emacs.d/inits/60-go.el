(add-to-list 'el-get-sources
    '(:name go-autocomplete
           :description "An autocompletion daemon for the Go programming language"
           :type github
           :pkgname "nsf/gocode"
           :depends (auto-complete)
           :features (go-autocomplete)
           :build (("go" "build" "-o" "gocode"))
           :build/windows-nt (("go" "build" "-o" "gocode.exe"))
           :load-path ("emacs")
           :prepare (progn
                      (add-to-list 'exec-path (el-get-package-directory "go-autocomplete")))))

(el-get 'sync '(go-mode go-autocomplete))
(add-hook 'go-mode-hook
          '(lambda ()
            (require 'go-autocomplete)
            (require 'auto-complete-config)
            (setq c-basic-offset 4)
            (setq indent-tabs-mode t)))

